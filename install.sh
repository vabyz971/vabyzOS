#!/usr/bin/env bash
# ==============================================================================
# vabyzOS — installateur interactif
# Applique la config sur un NixOS DÉJÀ installé : crée ou reconfigure une
# machine (hosts/<nom>/settings.nix), choisit les modules, gère le mot de passe,
# puis lance nixos-rebuild.
# ==============================================================================
# shellcheck disable=SC2034  # PRESET_* sont lus via ${!var} dans load_defaults
set -euo pipefail

REPO_URL="https://github.com/vabyz971/vabyzOS"
NIX=(nix --extra-experimental-features "nix-command flakes")
export NIX_CONFIG="experimental-features = nix-command flakes"

SOPS_KEY="/var/lib/sops-nix/key.txt"
LOCAL_HASH="/var/lib/vabyzos/password.hash"

# Préréglages de modules (modules/optional/) proposés pour une nouvelle machine
PRESET_workstation="zen-kernel appimage vivaldi zen-browser development docker fonts game gnome-app nautilus pkgs-store qemu noctalia noctalia-greeter niri blip"
PRESET_laptop="zen-browser fonts gnome-app yazi pkgs-store noctalia noctalia-greeter niri blip"
PRESET_vm="appimage pkgs-store vivaldi zen-browser fonts gnome-app nautilus noctalia noctalia-greeter niri vm-guest"
PRESET_minimal="fonts noctalia noctalia-greeter niri"

# ==================== Outils ====================

die() {
    if command -v gum >/dev/null; then
        gum style --foreground 196 "✖ $*" >&2
    else
        echo "✖ $*" >&2
    fi
    exit 1
}
ok() { gum style --foreground 46 "✔ $*"; }
info() { gum style --foreground 51 "ℹ $*"; }
warn() { gum style --foreground 226 "⚠ $*"; }
step() {
    echo
    gum style --bold --foreground 201 "▶ $*"
}

# Récupère les outils via nix (rien n'est installé sur le système)
load_tools() {
    echo "Préparation des outils (gum, jq, git, sops, age, mkpasswd)..."
    local paths p
    paths=$("${NIX[@]}" build --no-link --print-out-paths \
        nixpkgs#gum nixpkgs#jq nixpkgs#git nixpkgs#sops nixpkgs#age nixpkgs#mkpasswd) ||
        die "Impossible de récupérer les outils avec nix (connexion internet ?)"
    for p in $paths; do
        [ -d "$p/bin" ] && PATH="$p/bin:$PATH"
    done
    export PATH
}

# Refuse les caractères qui casseraient le fichier Nix généré
valid_str() { [[ "$1" != *'"'* && "$1" != *'\'* && "$1" != *'$'* ]]; }

# ask <variable> <question> <valeur par défaut> [regex]
ask() {
    local __var=$1 question=$2 default=$3 regex=${4:-} answer
    while true; do
        answer=$(gum input --header "$question" --value "$default" --char-limit 200) || exit 1
        if ! valid_str "$answer"; then
            warn "Caractères interdits : \" \\ \$"
        elif [ -n "$regex" ] && ! [[ "$answer" =~ $regex ]]; then
            warn "Valeur invalide."
        else
            break
        fi
    done
    printf -v "$__var" '%s' "$answer"
}

in_list() { [[ " $2 " == *" $1 "* ]]; }

# ==================== Dépôt ====================

locate_repo() {
    local script_dir
    script_dir=$(cd "$(dirname "${BASH_SOURCE[0]:-.}")" 2>/dev/null && pwd || true)
    if [ -n "$script_dir" ] && [ -f "$script_dir/flake.nix" ] && [ -d "$script_dir/hosts" ]; then
        CONFIG_DIR=$script_dir
    else
        CONFIG_DIR="$HOME/vabyzOS"
    fi

    if [ ! -f "$CONFIG_DIR/flake.nix" ]; then
        gum confirm "Dépôt introuvable. Cloner $REPO_URL dans $CONFIG_DIR ?" || exit 0
        git clone "$REPO_URL" "$CONFIG_DIR"
    fi
    cd "$CONFIG_DIR"
    ok "Dépôt : $CONFIG_DIR"
}

# ==================== Détection matérielle ====================

detect_hardware() {
    DETECT_LAPTOP=false
    compgen -G "/sys/class/power_supply/BAT*" >/dev/null && DETECT_LAPTOP=true

    DETECT_VIRT=$(systemd-detect-virt 2>/dev/null || true)
    [ "$DETECT_VIRT" = "none" ] && DETECT_VIRT=""

    # Carte graphique NVIDIA (vendor 0x10de, classe 0x03xxxx = affichage)
    DETECT_NVIDIA=false
    local dev
    for dev in /sys/bus/pci/devices/*; do
        if [ "$(cat "$dev/vendor" 2>/dev/null)" = "0x10de" ] &&
            [[ "$(cat "$dev/class" 2>/dev/null)" == 0x03* ]]; then
            DETECT_NVIDIA=true
        fi
    done

    info "Portable : $DETECT_LAPTOP · VM : ${DETECT_VIRT:-non} · NVIDIA : $DETECT_NVIDIA"
}

# ==================== Choix de la machine ====================

list_hosts() {
    local d
    for d in hosts/*/; do
        [ -f "$d/settings.nix" ] && basename "$d"
    done
}

select_host() {
    step "Machine"
    local choice
    choice=$( (list_hosts; echo "+ Nouvelle machine") |
        gum choose --header "Quelle machine configurer ?") || exit 1

    if [ "$choice" = "+ Nouvelle machine" ]; then
        IS_NEW=true
        while true; do
            ask HOST "Nom de la machine (dossier hosts/, ex: laptop-salon)" "" '^[a-z0-9][a-z0-9-]*$'
            [ -e "hosts/$HOST" ] && warn "hosts/$HOST existe déjà." || break
        done
    else
        IS_NEW=false
        HOST=$choice
    fi
}

# Charge les valeurs actuelles (machine existante) ou des valeurs proposées
load_defaults() {
    if [ "$IS_NEW" = false ]; then
        local json
        json=$("${NIX[@]}" eval --json --file "hosts/$HOST/settings.nix") ||
            die "hosts/$HOST/settings.nix illisible"
        get() { jq -r ".$1 // empty" <<<"$json"; }
        getl() { jq -r "(.$1 // []) | join(\" \")" <<<"$json"; }
        S_HOSTNAME=$(get hostName)
        S_USER=$(get username)
        S_GITNAME=$(get gitUsername)
        S_GITMAIL=$(get gitEmail)
        S_LOCALE=$(get locale)
        S_TZ=$(get timezone)
        S_KB=$(get keyboardLayout)
        S_KBOPT=$(get keyboardOptions)
        S_LAPTOP=$(get isLaptop)
        S_PASSMODE=$(get passwordMode)
        S_MODULES=$(getl modules)
        S_HOMEMODULES=$(getl homeModules)
    else
        S_HOSTNAME="${HOST}-vabyz"
        S_USER=$USER
        S_GITNAME=$(git config --global user.name 2>/dev/null || echo "$USER")
        S_GITMAIL=$(git config --global user.email 2>/dev/null || true)
        S_LOCALE=${LANG:-fr_FR.UTF-8}
        [[ "$S_LOCALE" == C* || "$S_LOCALE" == POSIX ]] && S_LOCALE="fr_FR.UTF-8"
        S_TZ=$(timedatectl show -p Timezone --value 2>/dev/null || echo "America/Toronto")
        S_KB="fr,us"
        S_KBOPT="grp:alt_shift_toggle"
        S_LAPTOP=$DETECT_LAPTOP
        S_PASSMODE=""
        S_HOMEMODULES=""

        local preset default_preset="workstation"
        [ "$DETECT_LAPTOP" = true ] && default_preset="laptop"
        [ -n "$DETECT_VIRT" ] && default_preset="vm"
        preset=$(gum choose --header "Préréglage de départ (modifiable ensuite)" \
            --selected "$default_preset" workstation laptop vm minimal) || exit 1
        local var="PRESET_$preset"
        S_MODULES=${!var}
        if [ "$DETECT_NVIDIA" = true ] && [ -z "$DETECT_VIRT" ]; then
            S_MODULES="nvidia $S_MODULES"
        fi
    fi
}

# ==================== Questions ====================

ask_identity() {
    step "Identité et langue"
    ask S_HOSTNAME "Nom réseau (hostname)" "$S_HOSTNAME" '^[a-zA-Z0-9-]+$'
    ask S_USER "Utilisateur" "$S_USER" '^[a-z_][a-z0-9_-]*$'
    ask S_GITNAME "Nom Git" "$S_GITNAME"
    ask S_GITMAIL "Email Git" "$S_GITMAIL"
    ask S_LOCALE "Langue (ex: fr_FR.UTF-8)" "$S_LOCALE" '^[A-Za-z_]+\.UTF-8$'
    ask S_TZ "Fuseau horaire (ex: Europe/Paris)" "$S_TZ" '^[A-Za-z_]+(/[A-Za-z_+-]+)*$'
    ask S_KB "Disposition clavier (ex: fr,us)" "$S_KB" '^[a-z]+(,[a-z]+)*$'
    ask S_KBOPT "Options clavier XKB" "$S_KBOPT"

    if [ "$S_USER" != "$USER" ]; then
        warn "Les utilisateurs sont gérés par la config (mutableUsers = false) :"
        warn "« $USER » sera supprimé au profit de « $S_USER »."
        gum confirm "Continuer avec « $S_USER » ?" --default=false || exit 0
    fi

    if gum confirm "Est-ce un portable ? (désactive power-profiles-daemon)" \
        --affirmative Oui --negative Non --default="$([ "$S_LAPTOP" = true ] && echo true || echo false)"; then
        S_LAPTOP=true
    else
        S_LAPTOP=false
    fi
}

# choose_modules <dossier> <sélection actuelle> → modules choisis (séparés par des espaces)
choose_modules() {
    local dir=$1 current=$2 header=$3 f name desc label
    local -a labels=() selected=()
    for f in "$dir"/*; do
        name=$(basename "$f" .nix)
        [ -d "$f" ] && f="$f/default.nix"
        [ -f "$f" ] || continue
        desc=$(sed -n 's/^# desc: //p' "$f" | head -1 | tr ',' ';')
        label=$(printf '%-18s %s' "$name" "$desc")
        labels+=("$label")
        in_list "$name" "$current" && selected+=("--selected=$label")
    done
    local picked m out=""
    picked=$(printf '%s\n' "${labels[@]}" |
        gum choose --no-limit --ordered --header "$header" "${selected[@]}" |
        awk '{print $1}' | tr '\n' ' ') || return 1
    # Conserve l'ordre existant, les nouveaux modules sont ajoutés à la fin
    for m in $current; do in_list "$m" "$picked" && out+=" $m"; done
    for m in $picked; do in_list "$m" "$out" || out+=" $m"; done
    echo "${out# }"
}

ask_modules() {
    step "Modules système"
    S_MODULES=$(choose_modules modules/optional "$S_MODULES" \
        "Modules système (espace = cocher, entrée = valider)") || exit 1
    info "Système : ${S_MODULES:-aucun}"

    # Pré-sélection des modules home selon les modules système
    if [ "$IS_NEW" = true ]; then
        local m
        for m in niri noctalia nautilus; do
            in_list "$m" "$S_MODULES" && S_HOMEMODULES+=" $m"
        done
        in_list qemu "$S_MODULES" && S_HOMEMODULES+=" virtmanager"
    fi
    step "Modules home-manager"
    S_HOMEMODULES=$(choose_modules home/optional "$S_HOMEMODULES" \
        "Modules utilisateur (espace = cocher, entrée = valider)") || exit 1
    info "Home : ${S_HOMEMODULES:-aucun}"
}

# ==================== Mot de passe ====================

# Vérifie que la clé sops déchiffre bien le mot de passe de l'utilisateur
sops_check() {
    sudo env "SOPS_AGE_KEY_FILE=$SOPS_KEY" "$(command -v sops)" -d \
        --extract "[\"secret\"][\"users\"][\"$S_USER\"]" secrets/secrets.yaml >/dev/null 2>&1
}

install_sops_key() {
    local key
    if [ -f secrets/age-key.age ] &&
        gum confirm "Déchiffrer la clé depuis secrets/age-key.age (phrase de passe) ?"; then
        key=$(age -d secrets/age-key.age) || { warn "Phrase de passe incorrecte."; return 1; }
    else
        key=$(gum input --password --header "Colle ta clé privée age (AGE-SECRET-KEY-...)") || return 1
    fi
    key=$(grep -o 'AGE-SECRET-KEY-[A-Z0-9]*' <<<"$key" | head -1)
    [ -n "$key" ] || { warn "Clé invalide."; return 1; }
    printf '%s\n' "$key" | sudo install -D -m 0600 -o root -g root /dev/stdin "$SOPS_KEY"
    ok "Clé installée dans $SOPS_KEY"
}

setup_local_password() {
    if [ "$S_PASSMODE" = local ] && sudo test -s "$LOCAL_HASH" &&
        gum confirm "Garder le mot de passe local actuel ?"; then
        return 0
    fi
    local p1 p2
    while true; do
        p1=$(gum input --password --header "Mot de passe pour $S_USER") || exit 1
        p2=$(gum input --password --header "Confirmer le mot de passe") || exit 1
        [ -n "$p1" ] && [ "$p1" = "$p2" ] && break
        warn "Vide ou différent, recommence."
    done
    printf '%s' "$p1" | mkpasswd -m yescrypt -s |
        sudo install -D -m 0600 -o root -g root /dev/stdin "$LOCAL_HASH"
    ok "Hash écrit dans $LOCAL_HASH (hors dépôt)"
}

ask_password() {
    step "Mot de passe"
    local default="sops"
    [ -n "$S_PASSMODE" ] && default=$S_PASSMODE
    [ -z "$S_PASSMODE" ] && ! sudo test -f "$SOPS_KEY" && [ ! -f secrets/age-key.age ] && default="local"

    # --selected compare le libellé affiché (pas la valeur après le « | »)
    local l_sops="sops  — même mot de passe sur toutes tes machines (clé age requise)"
    local l_local="local — mot de passe propre à cette machine, stocké hors du dépôt"
    local l_default=$l_sops
    [ "$default" = local ] && l_default=$l_local
    S_PASSMODE=$(gum choose --header "Source du mot de passe" --selected "$l_default" \
        --label-delimiter "|" "$l_sops|sops" "$l_local|local") || exit 1

    if [ "$S_PASSMODE" = sops ]; then
        until sudo test -f "$SOPS_KEY" && sops_check; do
            if sudo test -f "$SOPS_KEY"; then
                warn "La clé de $SOPS_KEY ne déchiffre pas secret/users/$S_USER."
            else
                warn "Aucune clé age dans $SOPS_KEY."
            fi
            # Sans secret valide, mutableUsers = false bloquerait la connexion
            local next
            next=$(gum choose --header "Que faire ?" \
                "Installer une autre clé" "Passer en mot de passe local" "Annuler") || exit 1
            case $next in
                "Installer une autre clé") install_sops_key || true ;;
                "Passer en mot de passe local") S_PASSMODE=local; break ;;
                *) exit 0 ;;
            esac
        done
        [ "$S_PASSMODE" = sops ] && ok "Clé sops valide pour $S_USER"
    fi
    [ "$S_PASSMODE" = local ] && setup_local_password
    return 0
}

# ==================== Génération ====================

nix_list() {
    local m
    for m in $1; do printf '    "%s"\n' "$m"; done
}

write_settings() {
    mkdir -p "hosts/$HOST"
    cat >"hosts/$HOST/settings.nix" <<EOF
# Réglages de la machine « $HOST » — généré par install.sh, modifiable à la main.
# Valeurs par défaut et description des champs : lib/default.nix (defaultSettings).
{
  hostName = "$S_HOSTNAME";
  username = "$S_USER";
  gitUsername = "$S_GITNAME";
  gitEmail = "$S_GITMAIL";

  locale = "$S_LOCALE";
  timezone = "$S_TZ";
  keyboardLayout = "$S_KB";
  keyboardOptions = "$S_KBOPT";

  isLaptop = $S_LAPTOP;
  passwordMode = "$S_PASSMODE";

  # Modules de modules/optional/
  modules = [
$(nix_list "$S_MODULES")
  ];

  # Modules home-manager de home/optional/
  homeModules = [
$(nix_list "$S_HOMEMODULES")
  ];
}
EOF

    if [ ! -f "hosts/$HOST/default.nix" ]; then
        cat >"hosts/$HOST/default.nix" <<EOF
# Réglages propres à « $HOST » (les modules sont choisis dans settings.nix)
{ ... }:
{
}
EOF
    fi
    ok "hosts/$HOST/settings.nix écrit"
}

write_hardware() {
    local file="hosts/$HOST/hardware.nix" args=()
    if [ "$IS_NEW" = false ] && [ -f "$file" ]; then
        gum confirm "Régénérer hosts/$HOST/hardware.nix depuis cette machine ?" --default=false ||
            return 0
    fi
    # Les partitions gérées par disko ne doivent pas être redéclarées
    grep -qs disko "hosts/$HOST/default.nix" && args+=(--no-filesystems)
    # shellcheck disable=SC2024  # le fichier est écrit dans le dépôt de l'utilisateur, pas par root
    sudo nixos-generate-config --show-hardware-config "${args[@]}" >"$file.tmp" ||
        die "nixos-generate-config a échoué"
    mv "$file.tmp" "$file"
    ok "$file généré"
}

show_summary() {
    step "Récapitulatif"
    gum style --border rounded --padding "0 2" --border-foreground 39 \
        "Machine      : $HOST $([ "$IS_NEW" = true ] && echo "(nouvelle)")" \
        "Hostname     : $S_HOSTNAME" \
        "Utilisateur  : $S_USER" \
        "Git          : $S_GITNAME <$S_GITMAIL>" \
        "Langue/TZ    : $S_LOCALE · $S_TZ" \
        "Clavier      : $S_KB ($S_KBOPT)" \
        "Portable     : $S_LAPTOP" \
        "Mot de passe : $S_PASSMODE" \
        "Système      : $S_MODULES" \
        "Home         : $S_HOMEMODULES"
    gum confirm "Écrire cette configuration ?" || { info "Annulé, rien n'a été modifié."; exit 0; }
}

apply() {
    step "Application"
    # Le flake ne voit que les fichiers suivis par git
    git add "hosts/$HOST"

    info "Vérification de la configuration..."
    "${NIX[@]}" eval --raw ".#nixosConfigurations.$HOST.config.system.build.toplevel.drvPath" >/dev/null ||
        die "La configuration ne s'évalue pas : corrige hosts/$HOST puis relance."
    ok "Configuration valide"

    local action
    action=$(gum choose --header "Appliquer maintenant ?" --label-delimiter "|" \
        "switch — appliquer tout de suite|switch" \
        "boot   — appliquer au prochain démarrage|boot" \
        "test   — essayer sans créer de génération|test" \
        "rien   — juste écrire les fichiers|none") || exit 1
    if [ "$action" != none ]; then
        sudo env "NIX_CONFIG=$NIX_CONFIG" nixos-rebuild "$action" --flake ".#$HOST" ||
            die "nixos-rebuild a échoué, voir les logs ci-dessus."
        ok "nixos-rebuild $action terminé"
    fi

    if gum confirm "Créer un commit git pour hosts/$HOST ?"; then
        git -c user.name="$S_GITNAME" -c user.email="$S_GITMAIL" \
            commit -m "hosts/$HOST: configuration via install.sh" -- "hosts/$HOST" &&
            info "Pense à faire git push pour le partager avec tes autres machines."
    fi
}

# ==================== Main ====================

main() {
    [ -f /etc/NIXOS ] || grep -qi nixos /etc/os-release 2>/dev/null ||
        die "Ce script fonctionne uniquement sur NixOS."
    [ "$(id -u)" -ne 0 ] || die "Lance le script avec ton utilisateur (sudo sera demandé au besoin)."

    load_tools
    clear
    gum style --border double --padding "0 2" --border-foreground 39 --bold \
        "🚀 vabyzOS — installateur" "Configuration d'un NixOS déjà installé"

    locate_repo
    detect_hardware
    select_host
    load_defaults
    ask_identity
    ask_modules
    ask_password
    show_summary
    write_settings
    write_hardware
    apply
    ok "Terminé !"
}

main "$@"

#!/usr/bin/env bash

# ==============================================================================
# INSTALLATION SCRIPT FOR MODULAR NIXOS CONFIG (vabyzOS)
# ==============================================================================

# Variables par défaut
REPO_URL="https://github.com/vabyz971/vabyzOS"
CONFIG_DIR="${HOME}/vabyzOS"
DEFAULT_BRANCH="main"

# Couleurs et styles
RESET='\e[0m'
BOLD='\e[1m'
DIM='\e[2m'
RED='\e[38;5;196m'
GREEN='\e[38;5;46m'
YELLOW='\e[38;5;226m'
BLUE='\e[38;5;39m'
MAGENTA='\e[38;5;201m'
CYAN='\e[38;5;51m'
WHITE='\e[38;5;231m'

# ==================== FONCTIONS D'AFFICHAGE UI ====================

draw_line() { echo -e "${BLUE}├──────────────────────────────────────────────────────────────┤${RESET}"; }
draw_top() { echo -e "${BLUE}╭──────────────────────────────────────────────────────────────╮${RESET}"; }
draw_bottom() { echo -e "${BLUE}╰──────────────────────────────────────────────────────────────╯${RESET}"; }

print_header() {
    clear
    draw_top
    echo -e "${BLUE}│${RESET} 🚀 ${BOLD}${CYAN}VABYZOS${RESET} - INSTALLATEUR DE CONFIGURATION NIXOS          ${BLUE}│${RESET}"
    draw_bottom
    echo ""
}

print_step() {
    echo ""
    echo -e "${BOLD}${MAGENTA}▶ $1${RESET}"
    echo -e "${DIM}  ----------------------------------------${RESET}"
}

print_success() { echo -e "  ${GREEN}✔${RESET} $1"; }
print_error()   { echo -e "  ${RED}✖${RESET} $1"; }
print_info()    { echo -e "  ${CYAN}ℹ${RESET} $1"; }
print_warning() { echo -e "  ${YELLOW}⚠${RESET} $1"; }

ask_input() {
    local prompt="$1"
    local default="$2"
    local result_var="$3"

    echo -ne "  ${BOLD}${WHITE}❯ ${prompt}${RESET} ${DIM}[${default}]${RESET}: "
    read -r user_input

    if [ -z "$user_input" ]; then
        eval $result_var="'$default'"
    else
        eval $result_var="'$user_input'"
    fi
}

# ==================== LOGIQUE ====================

check_nixos() {
    print_step "Vérification du système"
    if [ ! -f /etc/os-release ] || ! grep -qi "nixos" /etc/os-release; then
        print_error "Ce script est compatible uniquement avec NixOS."
        exit 1
    fi
    print_success "Système NixOS détecté avec succès"
}

collect_user_info() {
    print_step "Configuration de l'utilisateur"

    CURRENT_USER=$(whoami)
    DEFAULT_GIT_EMAIL="${CURRENT_USER}@gmail.com"

    ask_input "Nom d'utilisateur système" "$CURRENT_USER" SYS_USERNAME
    ask_input "Nom d'utilisateur Git" "$SYS_USERNAME" GIT_USERNAME
    ask_input "Email Git" "$DEFAULT_GIT_EMAIL" GIT_EMAIL
    ask_input "Disposition clavier système" "fr" KEYBOARD_LAYOUT
    ask_input "Disposition clavier console" "fr" CONSOLE_KEYMAP
    ask_input "Langue système (ex: fr_FR.UTF-8)" "fr_FR.UTF-8" LOCALE
}

select_profile() {
    print_step "Sélection du profil d'installation (Flake)"

    echo -e "  ${CYAN}1)${RESET} Workstation ${DIM}(Configuration principale Infographie/Dev)${RESET}"
    echo -e "  ${CYAN}2)${RESET} Chromebook  ${DIM}(Laptop allégé)${RESET}"
    echo -e "  ${CYAN}3)${RESET} VM          ${DIM}(Machine virtuelle de test)${RESET}"
    echo ""

    local valid=0
    while [ $valid -eq 0 ]; do
        echo -ne "  ${BOLD}❯ Choix [1-3]: ${RESET}"
        read -r choice
        case $choice in
            1) FLAKE_PROFILE="workstation"; HOST_TYPE="desktop"; valid=1 ;;
            2) FLAKE_PROFILE="chromebook"; HOST_TYPE="laptop"; valid=1 ;;
            3) FLAKE_PROFILE="vm"; HOST_TYPE="vm"; valid=1 ;;
            *) print_error "Choix invalide." ;;
        esac
    done
    print_success "Profil sélectionné : ${BOLD}${FLAKE_PROFILE}${RESET}"
}

generate_variables_file() {
    print_step "Génération de variables.nix"

    # Écriture à la racine du projet
    local var_file="${CONFIG_DIR}/variables.nix"

    cat > "$var_file" << EOF
# Fichier généré automatiquement par install.sh
inputs: {
  username = "${SYS_USERNAME}";

  gitUsername = "${GIT_USERNAME}";
  gitEmail = "${GIT_EMAIL}";

  keyboardLayout = "${KEYBOARD_LAYOUT}";
  consoleKeyMap = "${CONSOLE_KEYMAP}";
  i18nLocalLanguage = "${LOCALE}";

  # Fonction utilitaire pour les imports absolus
  basePath = path: inputs.self + "/\${path}";

  # Informations sur la machine courante
  profile = "${FLAKE_PROFILE}";
  host = "${HOST_TYPE}";
}
EOF
    print_success "Fichier racine créé : ${BOLD}variables.nix${RESET}"
}

generate_hardware_config() {
    print_step "Génération matérielle"

    local hardware_dir="${CONFIG_DIR}/hosts/${FLAKE_PROFILE}"
    local hardware_file="${hardware_dir}/hardware.nix"

    mkdir -p "$hardware_dir"

    if sudo nixos-generate-config --show-hardware-config > "$hardware_file"; then
        print_success "Configuration matérielle détectée et sauvegardée dans hosts/${FLAKE_PROFILE}/hardware.nix"
    else
        print_error "Échec de nixos-generate-config."
        exit 1
    fi
}

show_summary() {
    print_step "Récapitulatif avant déploiement"

    draw_top
    echo -e "${BLUE}│${RESET} Utilisateur   : ${CYAN}${SYS_USERNAME}${RESET}"
    echo -e "${BLUE}│${RESET} Git Account   : ${CYAN}${GIT_USERNAME} <${GIT_EMAIL}>${RESET}"
    echo -e "${BLUE}│${RESET} Clavier/Langue: ${CYAN}${KEYBOARD_LAYOUT} / ${LOCALE}${RESET}"
    echo -e "${BLUE}│${RESET} Profil Cible  : ${GREEN}${BOLD}${FLAKE_PROFILE}${RESET} (${HOST_TYPE})"
    draw_bottom
    echo ""

    echo -ne "  ${BOLD}${YELLOW}❯ Appliquer cette configuration maintenant ? (o/N) : ${RESET}"
    read -r confirm
    [[ $confirm =~ ^[OoYy]$ ]] || { print_info "Installation annulée par l'utilisateur."; exit 0; }
}

run_nixos_rebuild() {
    print_step "Installation en cours..."

    cd "${CONFIG_DIR}" || exit 1

    # On ajoute les fichiers générés à Git pour que le Flake les détecte
    print_info "Ajout des fichiers à Git..."
    git add variables.nix "hosts/${FLAKE_PROFILE}/hardware.nix"

    print_info "Lancement de nixos-rebuild (sudo requis)..."
    if sudo nixos-rebuild switch --flake ".#${FLAKE_PROFILE}"; then
        echo ""
        draw_top
        echo -e "${BLUE}│${RESET} 🎉 ${BOLD}${GREEN}INSTALLATION TERMINÉE AVEC SUCCÈS !${RESET}              ${BLUE}│${RESET}"
        draw_bottom
    else
        echo ""
        print_error "Le déploiement a échoué. Vérifie les logs Nix ci-dessus."
        exit 1
    fi
}

# ==================== MAIN EXÉCUTION ====================

main() {
    # S'assurer d'être dans le répertoire de config s'il existe déjà
    if [ -d "${CONFIG_DIR}" ]; then
        cd "${CONFIG_DIR}" || exit 1
    fi

    print_header
    check_nixos
    collect_user_info
    select_profile
    show_summary

    generate_variables_file
    generate_hardware_config
    run_nixos_rebuild
}

main

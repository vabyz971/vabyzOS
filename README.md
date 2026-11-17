<div align="center">

```
██╗   ██╗ █████╗ ██████╗ ██╗   ██╗███████╗ ██████╗ ███████╗
██║   ██║██╔══██╗██╔══██╗╚██╗ ██╔╝╚══███╔╝██╔═══██╗██╔════╝
██║   ██║███████║██████╔╝ ╚████╔╝   ███╔╝ ██║   ██║███████╗
╚██╗ ██╔╝██╔══██║██╔══██╗  ╚██╔╝   ███╔╝  ██║   ██║╚════██║
 ╚████╔╝ ██║  ██║██████╔╝   ██║   ███████╗╚██████╔╝███████║
  ╚═══╝  ╚═╝  ╚═╝╚═════╝    ╚═╝   ╚══════╝ ╚═════╝ ╚══════╝
```

**Ma configuration NixOS personnelle — reproductible, modulaire et prête à l'emploi.**

[![NixOS](https://img.shields.io/badge/NixOS-25.11-informational?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8aadf4)](https://nixos.org)
[![nixpkgs](https://img.shields.io/badge/nixpkgs-unstable-informational?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8aadf4)](https://github.com/NixOS/nixpkgs)
[![License: MIT](https://img.shields.io/badge/License-MIT-informational?style=flat&colorA=24273A&colorB=a6da95)](LICENSE)
[![Flakes](https://img.shields.io/badge/Flakes-enabled-informational?style=flat&colorA=24273A&colorB=f5a97f)](https://nixos.wiki/wiki/Flakes)

</div>

---

## Sommaire

- [Aperçu](#-aperçu)
- [Configuration requise](#️-configuration-requise)
- [Structure du projet](#️-structure-du-projet)
- [Machines (hosts)](#-machines-hosts)
- [Environnement graphique](#-environnement-graphique)
- [Logiciels inclus](#-logiciels-inclus)
- [Installation](#-installation)
- [Commandes utiles](#-commandes-utiles)
- [Secrets (SOPS)](#-secrets-sops)
- [Inspiration](#-inspiration)
- [Licence](#-licence)

---

## ✦ Aperçu

> vabyzOS est une configuration NixOS complète basée sur **Nix Flakes** et **Home Manager**. Elle vise une expérience de bureau cohérente, reproductible et facile à déployer sur une nouvelle machine.

L'environnement s'articule autour du **compositeur Wayland Niri** avec le shell **Noctalia V5**, une gestion des secrets via **SOPS-nix**, et un ensemble d'outils de développement prêts à l'emploi.

---

## ⚙️ Configuration requise

| Composant | Minimum |
|---|---|
| **OS** | NixOS 25.11 |
| **GPU** | Nvidia (host `workstation`) |
| **Boot** | 1 Go |
| **Espace disque** | 20 Go |
| **Packages** | Stable + Unstable |

---

## 🗂️ Structure du projet

```
vabyzOS/
├── flake.nix          # Point d'entrée principal (Flakes)
├── lib/               # Helpers d'import + réglages par défaut (defaultSettings)
├── hosts/             # Une machine = un dossier (détecté automatiquement par le flake)
│   │                  #   settings.nix : utilisateur, langue, modules… (généré par install.sh)
│   │                  #   hardware.nix : matériel · default.nix : réglages propres à la machine
│   ├── workstation/   # Poste principal (Nvidia, gaming, dev)
│   ├── vm/            # Machine virtuelle (QEMU/Hyper-V/VMware)
│   └── chromebook/    # Chromebook (disko, audio SOF, firmware)
├── modules/            # Modules NixOS réutilisables
│   ├── core/           # Socle commun à tous les hosts
│   └── optional/        # Modules activés à la carte par host
├── home/                # Configuration Home Manager
│   ├── core/            # Shell, git, éditeur, terminal
│   └── optional/         # Niri, Noctalia, virt-manager…
├── secrets/             # Secrets chiffrés (SOPS, jamais en clair)
├── ssh-keys/            # Clés SSH publiques autorisées par le module ssh (une par poste)
└── install.sh           # Script d'installation automatisé
```

---

## 🖥️ Machines (hosts)

Le flake expose trois configurations, chacune adaptée à un usage précis :

| Host | Usage | Particularités |
|---|---|---|
| `workstation` | Poste principal | GPU Nvidia, gaming (Steam/Lutris/Bottles), dev, virtualisation QEMU |
| `vm` | Machine virtuelle | Guest additions QEMU / Hyper-V / VMware / Spice, sans pilote GPU dédié |
| `chromebook` | Chromebook converti | Partitionnement via **disko**, correctif audio SOF, firmware `MrChromebox` |

Pour builder un host en particulier :

```bash
sudo nixos-rebuild switch --flake .#workstation
```

---

## 🎨 Environnement graphique

### Window Manager — Niri

Compositeur Wayland tiling minimaliste, orienté clavier.

| Dépendance | Rôle |
|---|---|
| `gpu-screen-recorder` | Enregistrement d'écran via GPU |

### Shell — Noctalia (Quickshell)

Shell graphique moderne construit avec Quickshell.

| Dépendance | Rôle |
|---|---|
| `brightnessctl` | Contrôle de la luminosité |
| `ddcutil` | Contrôle moniteur externe |
| `polkit` | Authentification graphique |
| `evolution-data-server` | Calendrier et contacts |

---

## 📦 Logiciels inclus

<details>
<summary><strong>🌐 Navigateurs</strong></summary>

- `vivaldi` — Navigateur principal
- `firefox` — Navigateur secondaire

</details>

<details>
<summary><strong>🛠️ Développement</strong></summary>

- `git`, `zed-editor`, `neovim`
- `python 3.15`, `nodejs 24`, `bun`
- `docker`, `docker-compose`
- `ghostty`, `zsh`

</details>

<details>
<summary><strong>🎮 Gaming</strong></summary>

- `steam`, `lutris`, `bottles`, `protonplus`

</details>

<details>
<summary><strong>💻 Virtualisation</strong></summary>

- `qemu`, `quickemu`, `virt-manager`

</details>

<details>
<summary><strong>🔧 Utilitaires</strong></summary>

- `htop`, `fastfetch`, `warp`
- `tailscale`, `poppler`, `appimage`
- `seahorse`, `gnome-software`, `flathub`
- `discord`

</details>

---

## 🚀 Installation

### Option 1 — Installateur interactif (NixOS déjà installé)

```bash
curl -L https://raw.githubusercontent.com/vabyz971/vabyzOS/main/install.sh | bash
# ou, depuis le dépôt cloné :
./install.sh
```

L'installateur (interface [`gum`](https://github.com/charmbracelet/gum), récupéré via nix, rien n'est installé) :

1. clone le dépôt dans `~/vabyzOS` s'il n'existe pas ;
2. détecte le matériel (portable, VM, GPU NVIDIA) ;
3. propose de **reconfigurer une machine existante** ou d'en **créer une nouvelle** à partir d'un préréglage (workstation, laptop, vm, minimal) ;
4. demande l'identité, la langue, le fuseau horaire et le clavier ;
5. affiche la liste des modules système et home-manager à cocher (la description vient de la ligne `# desc:` en tête de chaque module) ;
6. configure le mot de passe :
   - **sops** : même mot de passe sur toutes tes machines (clé age requise, vérifiée avant d'aller plus loin) ;
   - **local** : mot de passe propre à la machine, hash stocké dans `/var/lib/vabyzos/password.hash`, jamais dans le dépôt ;
7. écrit `hosts/<machine>/settings.nix` (+ `hardware.nix`), vérifie que la config s'évalue, puis lance `nixos-rebuild` (switch, boot, test ou rien) et propose un commit.

### Option 2 — Manuelle

```bash
git clone https://github.com/vabyz971/vabyzOS ~/vabyzOS
cd ~/vabyzOS

# Copier un host existant et adapter ses réglages
cp -r hosts/vm hosts/ma-machine
$EDITOR hosts/ma-machine/settings.nix
sudo nixos-generate-config --show-hardware-config > hosts/ma-machine/hardware.nix
git add hosts/ma-machine

sudo nixos-rebuild switch --flake .#ma-machine
```

> [!NOTE]
> Le flake ne voit que les fichiers suivis par git : pense au `git add` après avoir créé une machine.

> [!IMPORTANT]
> Les utilisateurs sont entièrement gérés par la config (`users.mutableUsers = false`) : `passwd` n'a aucun effet durable. Change le mot de passe via sops ou en relançant `install.sh`.

---

## 🧰 Commandes utiles

Le shell embarque [`nh`](https://github.com/nix-community/nh) (Nix Helper) pour des rebuilds plus lisibles, ainsi qu'un jeu d'alias définis dans [`home/core/zsh/aliases.nix`](home/core/zsh/aliases.nix).

| Alias | Commande | Description |
|---|---|---|
| `vupdate` | `nh os switch` | Rebuild + switch la configuration |
| `vupgrade` | `nix flake update` + `nh os switch` | Met à jour les inputs puis rebuild |
| `vboot` | `nh os boot` | Applique au prochain redémarrage |
| `vtest` | `nh os test` | Applique sans créer de génération |
| `vgc` | `nh clean all` | Garbage collect du store Nix |
| `vcheck` | `nix flake check` | Valide le flake |
| `vgens` | `nh os generations` | Liste les générations du système |
| `ll` / `lt` | `eza …` | Listing détaillé / arborescence |

Tape simplement **`vhelp`** dans un terminal pour afficher la liste complète et à jour de toutes ces commandes.

Le nettoyage automatique du store est aussi programmé côté système (`nix.gc`, hebdomadaire) avec `nix.settings.auto-optimise-store` activé.

---

## 🔐 Secrets (SOPS)

Les secrets sont gérés via [SOPS-nix](https://github.com/Mic92/sops-nix) et chiffrés avec une clé Age. La configuration se trouve dans `.sops.yaml`. Seuls les fichiers chiffrés du dossier `secrets/` sont versionnés — jamais de clé ou de secret en clair dans le dépôt.

---

## 💡 Inspiration

Ce projet s'inspire des dotfiles suivants :

- [ZaneyOS](https://gitlab.com/Zaney/zaneyos/) — by **Zaney**
- [NixOS-Hyprland](https://github.com/JaKooLit/NixOS-Hyprland) — by **JaKooLit**
- [nix-config](https://github.com/EmergentMind/nix-config) — by **EmergentMind**

---

## 📄 Licence

Distribué sous licence **MIT**. Voir [LICENSE](LICENSE) pour plus de détails.

---

<div align="center">

*Fait avec ❄️ et NixOS*

</div>

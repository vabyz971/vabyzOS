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

## ✦ Aperçu

> vabyzOS est une configuration NixOS complète basée sur **Nix Flakes** et **Home Manager**. Elle vise une expérience de bureau cohérente, reproductible et facile à déployer sur une nouvelle machine.

L'environnement s'articule autour du **compositeur Wayland Niri** avec le shell **Noctalia** (Quickshell), une gestion des secrets via **SOPS-nix**, et un ensemble d'outils de développement prêts à l'emploi.

---

## ⚙️ Configuration requise

| Composant | Minimum |
|-----------|---------|
| **OS** | NixOS 25.11 |
| **GPU** | Nvidia |
| **Boot** | 1 Go |
| **Espace disque** | 20 Go |
| **Packages** | Stable + Unstable |

---

## 🗂️ Structure du projet

```
vabyzOS/
├── flake.nix          # Point d'entrée principal (Flakes)
├── variables.nix      # Variables globales (hostname, user…)
├── hosts/             # Configurations par machine
├── modules/           # Modules NixOS réutilisables
├── home/              # Configuration Home Manager
├── secrets/           # Secrets chiffrés (SOPS)
└── install.sh         # Script d'installation automatisé
```

---

## 🖥️ Environnement

### Window Manager — Niri
Compositeur Wayland tiling minimaliste, orienté clavier.

| Dépendances |
|-------------|
| `gpu-screen-recorder` — Enregistrement d'écran via GPU |

### Shell — Noctalia (Quickshell)
Shell graphique moderne construit avec Quickshell.

| Dépendances |
|-------------|
| `quickshell` — Base du shell |
| `brightnessctl` — Contrôle de la luminosité |
| `imagemagick` — Manipulation d'images |
| `ddcutil` — Contrôle moniteur externe |
| `polkit_gnome` — Authentification graphique |
| `cliphist` — Historique du presse-papier |
| `cava` — Visualiseur audio |
| `wlsunset` — Filtre de lumière bleue |
| `xdg-desktop-portal-gnome` — Portails desktop |
| `evolution-data-server` — Calendrier et contacts |

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
- `kitty`, `zsh`

</details>

<details>
<summary><strong>🎮 Gaming</strong></summary>

- `steam`, `lutris`, `bottles`, `protonplus`

</details>

<summary><strong>💻 Virtualisation</strong></summary>

- `qemu`, `virt-manager`

</details>

<details>
<summary><strong>🔧 Utilitaires</strong></summary>

- `htop`, `fastfetch`, `warp`
- `tailscale`,`poppler`, `appimage`
- `seahorse`, `gnome-software`, `flathub`
- `discord`

</details>

---

## 🚀 Installation

### Option 1 — Script automatique

```bash
curl -L https://raw.githubusercontent.com/vabyz971/vabyzOS/main/install.sh | bash
```

### Option 2 — Manuelle

```bash
# 1. Ouvrir un shell avec git
nix-shell -p git

# 2. Cloner le dépôt
git clone https://github.com/vabyz971/vabyzOS

# 3. Adapter variables.nix à ta machine
# (hostname, username, GPU…)

# 4. Appliquer la configuration
sudo nixos-rebuild switch --flake .#<ton-hostname>
```

> [!NOTE]
> Pense à adapter `variables.nix` avec ton nom d'utilisateur et ton nom de machine avant d'appliquer la configuration.

---

## 🔐 Secrets (SOPS)

Les secrets sont gérés via [SOPS-nix](https://github.com/Mic92/sops-nix) et chiffrés avec une clé Age. La configuration se trouve dans `.sops.yaml`.

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

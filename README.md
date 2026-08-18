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

L'environnement s'articule autour du **compositeur Wayland Niri** avec le shell **Noctalia** (Quickshell), une gestion des secrets via **SOPS-nix**, et un ensemble d'outils de développement prêts à l'emploi.

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
├── variables.nix      # Variables globales (hostname, user…)
├── hosts/             # Configurations par machine
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
cd vabyzOS

# 3. Adapter variables.nix à ta machine
# (hostname, username, GPU…)

# 4. Appliquer la configuration
sudo nixos-rebuild switch --flake .#<ton-hostname>
```

> [!NOTE]
> Pense à adapter `variables.nix` avec ton nom d'utilisateur et ton nom de machine avant d'appliquer la configuration.

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

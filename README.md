<div align="center"> 

<h1>VABYZ OS <img width="25vh" src="img/logo_nixos.png" /> Nixos Configs</h1>

 ![nixos](https://img.shields.io/badge/nixpkgs-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8aadf4)
 ![nixpkgs](https://img.shields.io/badge/nixpkgs-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8aadf4)
 
<h3>Welcome to my nixos setup.</h3>

</div>


## Requirements
 - Version nixos : 25.11
 - Version packages : stable and unstable
 - Boot partition: 1Go required
 - Space disk : 20go
 - GPU : Nvidia


## WM Niri
|Dependencies|
|---|
|[gpu-screen-recorder](https://search.nixos.org/packages?channel=25.11&query=gpu-screen-recorder)|


## Shell Noctalia
|Dependencies|
|---|
|[quickshell](https://search.nixos.org/packages?channel=25.11&query=quickshell)|
|[brightnessctl](https://search.nixos.org/packages?channel=25.11&query=brightnessctl)|
|[imagemagick](https://search.nixos.org/packages?channel=25.11&query=imagemagick)|
|[ddcutil](https://search.nixos.org/packages?channel=25.11&query=ddcutil)|
|[polkit_gnome](https://search.nixos.org/packages?channel=25.11&query=polkit_gnome)|
|[cliphist](https://search.nixos.org/packages?channel=25.11&query=cliphist)|
|[cava](https://search.nixos.org/packages?channel=25.11&query=cava)|
|[wlsunset](https://search.nixos.org/packages?channel=25.11&query=wlsunset )|
|[xdg-desktop-portal-gnome](https://search.nixos.org/packages?channel=25.11&query=xdg-desktop-portal-gnome)|
|[evolution-data-server](https://search.nixos.org/packages?channel=25.11&query=evolution-data-server)|

## Software

|               |
|---------------|
|[vivaldi](https://search.nixos.org/packages?channel=25.11&query=vivaldi)        |
|[firefox](https://search.nixos.org/packages?channel=25.11&query=firefox)        |
|[git](https://search.nixos.org/packages?channel=25.11&query=git)            |
|[zed-editor](https://search.nixos.org/packages?channel=25.11&query=zed-editor)     |
|[appimage](https://search.nixos.org/packages?channel=25.11&query=appimage)       |
|[discord](https://search.nixos.org/packages?channel=25.11&query=discord)        |
|[htop](https://search.nixos.org/packages?channel=25.11&query=htop)           |
|[fastfetch](https://search.nixos.org/packages?channel=25.11&query=fastfetch)      |
|python 3.15    |
|nodejs 24      |
|[bun](https://search.nixos.org/packages?channel=25.11&query=bun)            |
|[steam](https://search.nixos.org/packages?channel=25.11&query=steam)          |
|FlatHub        |
|[software](https://search.nixos.org/packages?channel=25.11&query=gnome-software)       |
|[zsh](https://search.nixos.org/packages?channel=25.11&query=zsh)            |
|[kitty](https://search.nixos.org/packages?channel=25.11&query=kitty)          |
|[neovim](https://search.nixos.org/packages?channel=25.11&query=neovim)         |
|[docker](https://search.nixos.org/packages?channel=25.11&query=docker)         |
|[docker-compose](https://search.nixos.org/packages?channel=25.11&query=docker-compose) |
|[lutris](https://search.nixos.org/packages?channel=25.11&query=lutris)        |
|[protonplus](https://search.nixos.org/packages?channel=25.11&query=protonplus)     |
|[bottles](https://search.nixos.org/packages?channel=25.11&query=bottles)        |
|[secrects](https://search.nixos.org/packages?channel=25.11&query=secrects)       |
|[seahorse](https://search.nixos.org/packages?channel=25.11&query=seahorse)        |
|[warp](https://search.nixos.org/packages?channel=25.11&query=warp)           |
|[poppler](https://search.nixos.org/packages?channel=25.11&query=poppler)        |
|[mpvpaper](https://search.nixos.org/packages?channel=25.11&query=mpvpaper)       |
|[qemu](https://search.nixos.org/packages?channel=25.11&query=qemu)           |
|[virt-manager](https://search.nixos.org/packages?channel=25.11&query=virt-manager)   |
|[tailscale](https://search.nixos.org/packages?channel=25.11&query=tailscale)      |
|[wireguard-tools](https://search.nixos.org/packages?channel=25.11&query=wireguard-tools)      |


## Installation:

<details>
<summary><strong> ⬇️ Install with script </strong></summary>

### 1. Install dependencies
```bash
nix-shell -p git
```

### 2. Clone the project
```bash
git clone https://github.com/vabyz971/vabyzOS
```
### or
```bash
curl -L https://raw.githubusercontent.com/vabyz971/vabyzOS/main/install.sh | bash
```
</details>

## Crédit:
Inspire projects: 
- [ZaneyOS alias Zaney](https://gitlab.com/Zaney/zaneyos/)
- [JaKooLit](https://github.com/JaKooLit/NixOS-Hyprland)
- [EmergentMind](https://github.com/EmergentMind/nix-config)

{ config, pkgs, ... }:
{
  users.mutableUsers = true;
  users.users = {
    vabyz971 = {
      isNormalUser = true;
      description = "vabyz971";
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbusers"
        "docker"
        "libvirtd"
      ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };
  };

  imports = [

    # Desktop Envirinement
    # ../common/desktop/gnome
    ../common/desktop/hyprland
    ../common/desktop/noctalia

    # Virtualisation
    ../common/optional/docker.nix
    ../common/optional/qemu.nix

    # Gaming
    ../common/optional/game.nix

    # Store Packages
    ../common/optional/appimage.nix
    ../common/optional/flatpak.nix

    # Etc...
    ../common/optional/fonts.nix
    ../common/optional/browsers.nix
    ../common/optional/development.nix
  ];
}

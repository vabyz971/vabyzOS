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

    ../common/core/sops.nix

    # Desktop Environement
    # ../common/desktop/gnome
    # ../common/desktop/hyprland
    ../common/desktop/niri

    # Shell Environement
    ../common/optional/noctalia.nix

    # Virtualisation
    ../common/optional/docker.nix
    ../common/optional/qemu.nix

    # Session manager
    ../common/optional/sddm.nix

    # Gaming
    ../common/optional/game.nix

    # Store Packages
    ../common/optional/appimage.nix
    ../common/optional/flatpak.nix

    # Etc...
    ../common/optional/fonts.nix
    ../common/optional/browsers.nix
    ../common/optional/development.nix
    ../common/optional/socialNetwork.nix
  ];
}

{ pkgs, ... }:
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

    # Session manager
    ../common/optional/sddm.nix

    # Desktop Environement
    ../common/desktop/niri

    # Shell Environement
    ../common/optional/noctalia.nix

    # Virtualisation
    ../common/optional/docker.nix
    ../common/optional/qemu.nix

    # Gaming
    ../common/optional/game.nix

    # Store Packages
    ../common/optional/appimage.nix
    ../common/optional/pkgs-store.nix

    # Etc...
    ../common/optional/fonts.nix
    ../common/optional/browsers.nix
    ../common/optional/development.nix
    ../common/optional/socialNetwork.nix
    ../common/optional/mpvpaper.nix
    ../common/optional/nautilus.nix
    ../common/optional/gnome-app.nix
  ];
}

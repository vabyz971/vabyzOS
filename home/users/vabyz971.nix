{ config, pkgs, ... }:
{
  users.users = {
    vabyz971 = {
      isNormalUser = true;
      description = "Principal user (development, work, gaming)";
      extraGroups = [
        "wheel" "networkmanager" "adbusers" "docker" "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };

  imports = [

    ../common/optional/browsers.nix
    ../common/optional/development.nix

    # STORE PACKAGES
    ../common/optional/flatpak.nix

    # Desktop
    ../common/desktop/gnome
  ];


  home = {
    username = "vabyz971";
    homeDirectory = "/home/vabyz971";
    stateVersion = "25.11";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "vivaldi";
    TERMINAL = "kitty";
  };
}
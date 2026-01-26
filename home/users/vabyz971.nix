{ config, ... }:
{

  home = {
    username = "vabyz971";
    homeDirectory = "/home/vabyz971";
    stateVersion = "25.11";
  };

  imports = [

    ../common/core

    # Desktop
    # ../common/desktop/gnome
    # ../common/desktop/hyprland
    # ../common/desktop/noctalia
    ../common/desktop/niri
    ../common/optional/vicinae.nix

    # Virtualisation
    ../common/optional/virtmanager.nix

  ];
}

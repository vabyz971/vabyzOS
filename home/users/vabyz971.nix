{ ... }:
{

  home = {
    username = "vabyz971";
    homeDirectory = "/home/vabyz971";
    stateVersion = "25.11";
  };

  imports = [

    ../common/core

    # Desktop
    ../common/desktop/niri
    ../common/optional/vicinae.nix
    ../common/optional/nautilus.nix

    # Virtualisation
    ../common/optional/virtmanager.nix

  ];
}

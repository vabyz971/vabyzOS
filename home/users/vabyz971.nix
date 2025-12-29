{ config, pkgs, ... }:
{

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

  imports = [

    ../common/core
    
    # Desktop
    ../common/desktop/gnome

  ];
}

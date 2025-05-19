{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (import ../../../global/variables.nix) clock24h;
in
  with lib; {
    # Configure & Theme Waybar
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
    };
  }

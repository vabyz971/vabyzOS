{ config, pkgs, ... }:
let
  inherit (import ../../global/variables.nix) keyboardLayout;
in
{

  services.xserver.enable = true;
  # For NixOS 25.11 or later
  services.desktopManager.pantheon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };
}

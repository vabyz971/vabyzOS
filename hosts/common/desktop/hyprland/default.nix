{ config, pkgs, ... }:
let
  inherit (import ../../../../global/variables.nix) keyboardLayout;
in
{

  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };

  imports = [
    ./sddm.nix
    ./hyprland.nix
  ];
}

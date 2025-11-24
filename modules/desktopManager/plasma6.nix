{ config, pkgs, ... }:
let
  inherit (import ../../global/variables.nix) keyboardLayout;
in
{

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Using Wayland (preferred)
  services.displayManager.sddm.settings.General.DisplayServer = "wayland";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };
}

{ inputs, pkgs, ... }: let
  inherit (import ../../global/variables.nix) keyboardLayout;
in {

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb.layout = "${keyboardLayout}";
    };
  };

  # Enable the XFCE Desktop DisplayManager.
  services.xserver.displayManager.lightdm.enable = true;

  # enable Hyprland
  programs.hyprland = {
    enable = true;
  };
}

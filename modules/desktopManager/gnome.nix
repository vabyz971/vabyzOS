{ config, ... }:
let
  inherit (import ../../global/variables.nix) keyboardLayout;
in
{

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # GVfs is a GNOME userspace virtual filesystem designed 
  # to work with the I/O abstraction of GIO
  services.gvfs.enable = true;

}
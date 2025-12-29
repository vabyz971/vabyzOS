{ config, pkgs, ... }:
let
  inherit (import ../../../../global/variables.nix) keyboardLayout;
in
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };

  # To disable installing GNOME's suite of applications
  # and only be left with GNOME shell.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    totem
    decibels
    epiphany
    yelp
    gnome-system-monitor
    gnome-tour
    gnome-user-docs
  ];

  home.packages = with pkgs; [

    # Application Gnome
    gnome-tweaks
    warp
    gnome-secrets
    poppler
  ];

  imports = [
    ./gtk.nix
  ];
}

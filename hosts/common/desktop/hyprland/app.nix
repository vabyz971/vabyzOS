{ pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = [
    
    # Application Gnome
    pkgs-unstable.bazaar
    pkgs.gnome-secrets
    pkgs.gnome-nettool
    pkgs.gnome-disk-utility
    pkgs.nautilus
    pkgs.nautilus-python
    pkgs.nautilus-open-any-terminal
    pkgs.sushi
    pkgs.image-roll
    pkgs.warp
    pkgs.poppler
    pkgs.showtime
    pkgs.seahorse
    
    # App for Hyrpland
    pkgs.wl-clipboard # Presse-papiers Wayland
    pkgs.wluma # tool Wayland compositors to automatically adjust screen brightness
    pkgs.easyeffects # Audio effects for PipeWire applications
    pkgs.hyprpolkitagent
    pkgs.hyprshot
  ];



  # Support pour Nautilus et trousseau de clés (et autres apps GTK/Gnome)
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; # Prévisualisation des miniatures
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.SDDM.enableGnomeKeyring = true;
  security.rtkit.enable = true;
}

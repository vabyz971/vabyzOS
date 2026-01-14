{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    
    # Application Gnome
    gnome-software
    gnome-secrets
    gnome-nettool
    gnome-disk-utility
    nautilus
    nautilus-python
    nautilus-open-any-terminal
    sushi
    image-roll
    warp
    poppler
    showtime
    seahorse
    
    # App for Hyrpland
    wl-clipboard # Presse-papiers Wayland
    wluma # tool Wayland compositors to automatically adjust screen brightness
    easyeffects # Audio effects for PipeWire applications
    hyprpolkitagent
    hyprshot
  ];

  # Support pour Nautilus et trousseau de clés (et autres apps GTK/Gnome)
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; # Prévisualisation des miniatures
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.SDDM.enableGnomeKeyring = true;
  security.rtkit.enable = true;
}

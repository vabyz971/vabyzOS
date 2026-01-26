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
    seahorse

    xwayland-satellite
  ];

  # Support pour Nautilus et trousseau de clés (et autres apps GTK/Gnome)
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; # Prévisualisation des miniatures
  services.gnome.gnome-keyring.enable = true;
}

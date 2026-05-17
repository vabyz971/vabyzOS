{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
    nautilus-python
    gnomeExtensions.flickernaut
    image-roll
  ];

  services.gnome.sushi.enable = true; # Prévisualisation des miniatures
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; 
  services.gnome.gnome-keyring.enable = true; # Support pour Nautilus et trousseau de clés (et autres apps GTK/Gnome)
}

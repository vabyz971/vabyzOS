{ pkgs, ... }:
{
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  environment.systemPackages = with pkgs; [
    nautilus
    nautilus-python
    gnomeExtensions.flickernaut
    image-roll
  ];

  services.gnome.sushi.enable = true;
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; # Prévisualisation des miniatures
  services.gnome.gnome-keyring.enable = true; # Support pour Nautilus et trousseau de clés (et autres apps GTK/Gnome)
}

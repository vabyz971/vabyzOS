{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # Application Gnome
    gnome-software
    gnome-secrets
    gnome-nettool
    nautilus
    nautilus-python
    warp
    poppler
    showtime

    # App for Hyrpland
    wl-clipboard # Presse-papiers Wayland
    wluma # tool Wayland compositors to automatically adjust screen brightness
    easyeffects # Audio effects for PipeWire applications
    hyprlandPlugins.hyprspace # Workspace overview plugin for Hyprland
    hyprpolkitagent
  ];

  # Support pour Nautilus (et autres apps GTK/Gnome)
  services.gvfs.enable = true; # Trash, volumes réseaux
  services.tumbler.enable = true; # Prévisualisation des miniatures
}

{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # Application Gnome
    gnome-software
    gnome-secrets
    gnome-nettool
    nautilus
    warp
    poppler
    vesktop
    showtime
  ];
}

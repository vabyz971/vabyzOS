{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # Application Gnome
    gnome-software
    nautilus
    warp
    gnome-secrets
    poppler
  ];
}

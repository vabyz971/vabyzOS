{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-secrets
    gnome-nettool
    gnome-disk-utility
    seahorse
    warp
    poppler
  ];
}

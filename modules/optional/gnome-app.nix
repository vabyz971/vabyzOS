# desc: Apps GNOME : secrets, disques, seahorse, warp
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnome-secrets
    gnome-keyring
    gnome-nettool
    gnome-disk-utility
    seahorse
    poppler
  ];
}

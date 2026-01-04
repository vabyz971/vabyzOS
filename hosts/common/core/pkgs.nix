{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    age
    sops
    fastfetch
    btop
    udisks          # Gestion des disques
    udiskie
    ntfs3g          # lire les clés formatées en NTFS
    cifs-utils      # Samba/CIFS (Windows, Synology, etc.)
  ];
}

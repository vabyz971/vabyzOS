{ config, pkgs, ... }:
{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      extraPackages = with pkgs; [
        gamescope
        mangohud
        goverlay
      ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--adaptive-sync"
        "--hdr-enabled"
        "--rt"
        "--steam"
        "--expose-wayland"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    lutris
    protontricks
  ];
}

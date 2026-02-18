{ pkgs, ... }:
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
        gamemode
        mangohud
      ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--hdr-enabled"
        "--rt"
        "--steam"
        "--expose-wayland"
      ];
    };
  };

  # 1. Activez le support matériel pour Steam
  hardware.steam-hardware.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    protonplus
    bottles
    game-devices-udev-rules
  ];
}

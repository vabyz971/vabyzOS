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

  environment.systemPackages = with pkgs; [
    lutris
    protonplus
    bottles
  ];
}

{ pkgs, ... }:
{

  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    wofi
    nwg-look
  ];
}

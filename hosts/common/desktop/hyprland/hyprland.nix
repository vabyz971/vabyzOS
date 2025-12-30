{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    nwg-look
    quickshell
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}

{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    nwg-look
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}

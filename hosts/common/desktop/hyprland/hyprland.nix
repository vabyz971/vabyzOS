{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    nwg-look
    wayshot # Native, blazing-fast screenshot tool for wlroots based compositors such as sway and river
    hyprdim # is a daemon that automatically dims windows in Hyprland when switching between them.
    wluma # tool Wayland compositors to automatically adjust screen brightness
    easyeffects # Audio effects for PipeWire applications
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}

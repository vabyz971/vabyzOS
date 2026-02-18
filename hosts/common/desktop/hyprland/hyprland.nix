{
  config,
  pkgs,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
}

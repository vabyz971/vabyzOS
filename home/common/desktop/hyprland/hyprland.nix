{
  pkgs,
  config,
  inputs,
  ...
}:
{
   wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      # A plugin for Hyprland that implements a workspace overview feature similar to that of KDE Plasma, GNOME and macOS, aimed to provide a efficient way of workspace and window management.
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.Hyprspace
    ];
  };
}
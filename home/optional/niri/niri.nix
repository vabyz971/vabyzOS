{
  pkgs,
  ...
}:
{
  programs.niri = {
    package = pkgs.niri-unstable;
    settings = {
      spawn-at-startup = [
        {
          command = [
            "noctalia-shell"
          ];
        }
      ];
      environment = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "niri";
        XDG_CURRENT_DESKTOP = "niri";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        MOZ_ENABLE_WAYLAND = "1";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";

      };
      xwayland-satellite.enable = true;

      # Animations fluides avec ressorts
      animations = {
        enable = true;
        horizontal-view-movement.enable = true;
      };
    };
  };
}

{ config, ... }:
{
  programs.niri = {
    settings = {

      environment = {
        NIXOS_OZONE_WL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "niri";
        XDG_CURRENT_DESKTOP = "niri";
        QT_QPA_PLATFORMTHEME = "gtk3";
        MOZ_ENABLE_WAYLAND = "1";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";

      };

      # Lancement au démarrage
      spawn-at-startup = [
        {
          command = [
            "vicinae server"
            "xwayland-satellite"
          ];
        }
      ];

      # Animations fluides avec ressorts
      animations = {
        enable = true;
        horizontal-view-movement.enable = true;
      };
    };
  };
}

{ ... }:
{
  wayland.windowManager.hyprland = {
    systemd.enableXdgAutostart = true;
    systemd.variables = [ "--all" ];
    settings.env = [
      "NIXOS_OZONE_WL, 1"
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"
      "XDG_SESSION_DESKTOP, Hyprland"
      "GDK_BACKEND, wayland, x11"
      "CLUTTER_BACKEND, wayland"
      "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
      "MOZ_ENABLE_WAYLAND, 1"
      "GDK_SCALE,1"
      "GTK_USE_PORTAL,1"
      "QT_SCALE_FACTOR,1"
      # This is to make electron apps start in wayland
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      "FLATPAK_ENABLE_SDK_EXT, *"

      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
  };
}

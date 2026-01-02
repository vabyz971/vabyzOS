{ ... }:
{
  wayland.windowManager.hyprland = {
    settings.env = [
      "NIXOS_OZONE_WL, 1"
      "XDG_CURRENT_DESKTOP, Hyprland"
      "XDG_SESSION_TYPE, wayland"
      "XDG_SESSION_DESKTOP, Hyprland"
      # This is to make electron apps start in wayland
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      "XDG_TERMINAL_EMULATOR,kitty"
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
    ];
  };
}

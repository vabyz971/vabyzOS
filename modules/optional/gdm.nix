{
  variables,
  ...
}:
{
  services.xserver.xkb = {
    layout = "${variables.keyboardLayout}";
    variant = "";
  };

  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.displayManager.defaultSession = "niri";
}

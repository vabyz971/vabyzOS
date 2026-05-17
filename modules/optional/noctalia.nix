{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  # install package
  environment.systemPackages = [

    # Dependencies Required
    pkgs-unstable.quickshell

    pkgs.brightnessctl
    pkgs.ddcutil

    # Polkit authentication dialogs
    pkgs.polkit_gnome

    # Optional
    pkgs.xdg-desktop-portal-gnome
  ];

  # Required for ddcutil
  hardware.i2c.enable = true;
}

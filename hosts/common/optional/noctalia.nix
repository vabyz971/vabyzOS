{
  pkgs,
  pkgs-unstable,
  inputs,
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

  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = true;
}

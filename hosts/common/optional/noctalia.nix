{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  # install package
  environment.systemPackages = with pkgs; [

    # Dependencies Required
    quickshell
    brightnessctl
    imagemagick

    # Hardware
    ddcutil

    # Optional
    cliphist
    cava
    wlsunset
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    evolution-data-server
  ];

  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = true;
}

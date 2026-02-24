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

    # Polkit authentication dialogs
    pkgs.polkit_gnome

    # Optional
    pkgs.xdg-desktop-portal-gnome
  ];

  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = true;
}

{
  pkgs,
  inputs,
  ...
}:
{

  # install package
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    pkgs.brightnessctl
    pkgs.ddcutil
  ];

  # Required for ddcutil
  hardware.i2c.enable = true;

  # Activation d'AccountsService pour les photos de profil (requis par Noctalia)
  services.accounts-daemon.enable = true;
}

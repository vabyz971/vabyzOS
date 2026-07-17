{
  pkgs,
  inputs,
  ...
}:
let
  noctalia-greeter-pkg = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${noctalia-greeter-pkg}/bin/noctalia-greeter-session";
          user = "greeter";
        };
      };
    };
  };

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

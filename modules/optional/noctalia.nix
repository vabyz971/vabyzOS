{
  pkgs,
  inputs,
  variables,
  ...
}:
let
  noctalia-greeter-pkg = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  services = {
    xserver.xkb = {
      layout = "${variables.keyboardLayout}";
      variant = "";
    };
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
}

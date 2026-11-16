{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;

    # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
    recommendedServices.enable = true;
  };

  environment.systemPackages = [
    pkgs.brightnessctl
    pkgs.ddcutil
  ];

  # Required for ddcutil
  hardware.i2c.enable = true;
}

{ pkgs, inputs, ... }:
{
  # install package
  environment.systemPackages = with pkgs; [
    quickshell
    gpu-screen-recorder
    nwg-look
    brightnessctl
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];

  imports = [
    inputs.noctalia.nixosModules.default
  ];
  # enable the systemd service
  services.noctalia-shell.enable = true;
}

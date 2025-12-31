{ pkgs, inputs, ... }:
{
  # install package
  environment.systemPackages = with pkgs; [
    quickshell
    brightnessctl
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];
}
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.superfile.packages.${stdenv.hostPlatform.system}.default
  ];
}

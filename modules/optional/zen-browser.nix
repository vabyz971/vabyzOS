# desc: Navigateur Zen
{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}

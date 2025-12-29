{ pkgs, ... }:
{

  home.packages = with pkgs; [
    android-tools
    python315
    nodejs_24
    corepack_24
    bun
    nixfmt
    vscodium
  ];
}

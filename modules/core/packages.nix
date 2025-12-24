{ pkgs, ... }:
{

  programs.appimage.enable = true;

  # Pour lire les binaires
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    git
    direnv
    btop
    vscodium
    android-tools
    fastfetch
    python315
    nodejs_24
    corepack_24
    bun
    nixfmt
  ];
}

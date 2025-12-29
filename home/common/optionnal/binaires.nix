{ pkgs, inputs, ... }:
{
  # Appimage
  programs.appimage.enable = true;

  # Binaires
  programs.nix-ld.enable = true;
}

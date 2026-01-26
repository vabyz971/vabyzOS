{ config, pkgs, ... }:
{

  imports = [
    ./hyprland.nix
    ./app.nix
    ./xdg.nix
  ];
}

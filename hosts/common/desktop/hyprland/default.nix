{ config, pkgs, ... }:
{

  imports = [
    ./sddm.nix
    ./hyprland.nix
    ./app.nix
    ./xdg.nix
  ];
}

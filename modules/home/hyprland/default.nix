{ ... }: let
in {
  imports = [
    ./hyprland.nix
    ./binds.nix
    ./monitors.nix
    # ./hypridle.nix
    # ./hyprlock.nix
    # ./pyprland.nix
    # ./windowrules.nix
  ];
}

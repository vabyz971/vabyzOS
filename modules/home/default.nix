{profile, ...}:
{
  imports = [
    # ./amfora.nix
    #./bash.nix
    # ./bashrc-personal.nix
    # ./bat.nix
    # ./btop.nix
    # ./cava.nix
    # ./emoji.nix
    # ./fastfetch
    # ./gh.nix
    # ./ghostty.nix
    ./git.nix
    # ./htop.nix
    #./hyprland
    # ./waybar
    ./kitty.nix
    # ./nvf.nix
    # ./rofi
    # ./qt.nix
    # ./scripts
    # ./starship.nix
    # ./swappy.nix
    # ./swaync.nix
    # ./virtmanager.nix
    # ./wezterm.nix
    # ./wlogout
    #./xdg.nix
    # ./yazi
    # ./zoxide.nix
    ./zsh
  ];

  imports = if profile == "gnome"
  then [ ./gtk.nix]
  else []

}

{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  # gestion file XFCE
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [
    firefox   # Browzer default
    git
    zsh
    hyprpaper
    fuzzel
    direnv
    vscodium   

    # Terminal
    alacritty
  ];
}

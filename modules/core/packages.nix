{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    firefox
    git
    direnv
    vscodium 

    # Terminal
    alacritty
  ];
}

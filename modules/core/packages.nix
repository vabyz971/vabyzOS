{ pkgs, system, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    inputs.zen-browser.packages."${system}".specific
    git
    direnv
    vscodium 

    # Terminal
    alacritty
  ];
}

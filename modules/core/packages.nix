{ pkgs, system, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    zen-browser
    git
    direnv
    vscodium 

    # Terminal
    alacritty
  ];
}

{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    inputs.zen-browser.packages.${pkgs.system}.default
    git
    direnv
    vscodium
    discord

    # Terminal
    alacritty
  ];
}

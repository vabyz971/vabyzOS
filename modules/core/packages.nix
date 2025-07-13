{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    inputs.zen-browser.packages.${pkgs.system}.default
    git
    direnv
    dconf
    vscodium
    discord
    stacer
    mission-center
    fastfetch
    zsh-powerlevel10k
    python313Full
    python313Packages.pip
    nodejs_24
    corepack_24
  ];
}

{ pkgs, inputs, ... }: {

  programs.appimage.enable

  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
    firefox
    git
    direnv
    dconf
    vscodium
    discord
    stacer
    mission-center
    fastfetch
    python313Full
    python313Packages.pip
    nodejs_24
    corepack_24
    bun
  ];
}

# desc: Navigateur Vivaldi
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vivaldi
    vivaldi-ffmpeg-codecs
  ];
}

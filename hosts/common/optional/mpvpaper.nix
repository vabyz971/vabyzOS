{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mpvpaper
  ];
}

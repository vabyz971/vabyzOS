{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  home.packages = with pkgs; [
    docker-compose
  ];
}

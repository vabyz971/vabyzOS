{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  virtualisation.docker.enableOnBoot = false;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}

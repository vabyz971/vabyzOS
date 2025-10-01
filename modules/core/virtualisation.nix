{ pkgs, ... }: {
  
  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;

  programs = {
    virt-manager.enable = true;
  };


environment.systemPackages = with pkgs; [
    docker-client
  ];
}
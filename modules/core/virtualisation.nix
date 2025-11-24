{ pkgs, ... }:
{

  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;
  virtualisation.libvirtd.enable = true;

  programs = {
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-client
    qemu_kvm
    docker-compose
  ];
}

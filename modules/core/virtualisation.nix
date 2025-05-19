{pkgs, ...}: let inherit (import ../../global/variables.nix) virtualisation;
in {
  # Only enable either docker -- Not both
  virtualisation = {
    libvirtd.enable = virtualisation;
    docker.enable = true;
  };
  programs = {
    virt-manager.enable = virtualisation;
  };
}

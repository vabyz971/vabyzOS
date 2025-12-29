{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs = {
    virt-manager.enable = true;
  };

  home.packages = with pkgs; [
    qemu_kvm
  ];
}

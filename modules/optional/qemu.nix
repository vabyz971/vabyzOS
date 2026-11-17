# desc: Virtualisation : libvirt, virt-manager, quickemu
{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs = {
    virt-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qemu_kvm
    quickemu
  ];
}

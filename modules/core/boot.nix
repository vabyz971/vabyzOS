{ config, pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # Multiboot
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}
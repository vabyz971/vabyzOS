{ config, pkgs, profile, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # Multiboot
    loader.systemd-boot.enable = if profile == "vm" then false else true;
    loader.efi.canTouchEfiVariables = if profile == "vm" then false else true;
  };
}

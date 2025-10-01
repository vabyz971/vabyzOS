{ ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    # Multiboot
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth.enable = true;
  }
}
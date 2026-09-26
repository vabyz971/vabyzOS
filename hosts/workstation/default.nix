{ helpers, config, ... }:
{
  imports = [
    ./hardware.nix

    # Core
    helpers.core
  ]
  ++ helpers.mods [
    # Driver
    "nvidia"

    # Pkgs
    "appimage"
    "browsers"
    "development"
    "docker"
    "fonts"
    "game"
    "gnome-app"
    "nautilus"
    "pkgs-store"
    "qemu"
    "openrgb"
    "noctalia"
    "noctalia-greeter"
    "niri"
    "blip"
  ];

  boot = {
    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

  networking.hostName = "workstation-vabyz";
}

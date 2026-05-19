{ variables, config, ... }:
{
  imports = [
    ./hardware.nix

    # Core
    (variables.basePath "modules/core")

    # Driver
    (variables.basePath "modules/optional/nvidia.nix")

    # Pkgs
    (variables.basePath "modules/optional/appimage.nix")
    (variables.basePath "modules/optional/browsers.nix")
    (variables.basePath "modules/optional/development.nix")
    (variables.basePath "modules/optional/docker.nix")
    (variables.basePath "modules/optional/fonts.nix")
    (variables.basePath "modules/optional/game.nix")
    (variables.basePath "modules/optional/gnome-app.nix")
    (variables.basePath "modules/optional/nautilus.nix")
    (variables.basePath "modules/optional/pkgs-store.nix")
    (variables.basePath "modules/optional/gdm.nix")
    (variables.basePath "modules/optional/socialNetwork.nix")
    (variables.basePath "modules/optional/spicetify.nix")
    (variables.basePath "modules/optional/vpn.nix")
    (variables.basePath "modules/optional/qemu.nix")
    (variables.basePath "modules/optional/noctalia.nix")
    (variables.basePath "modules/optional/niri.nix")

  ];

  boot = {
    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    blacklistedKernelModules = [ "nova_core" ];
  };

  networking.hostName = "workstation-vabyz";
}

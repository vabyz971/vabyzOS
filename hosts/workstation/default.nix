# Réglages propres au workstation (les modules sont choisis dans settings.nix)
{ config, ... }:
{

  boot = {
    # Virtual device
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };

}

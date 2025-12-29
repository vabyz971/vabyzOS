{ ... }:
{
  imports = [
    ./hardware.nix
    ../common/core
    ./config.nix
    ../common/optional/nvidia.nix
  ]
}
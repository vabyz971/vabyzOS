{ ... }:
{
  imports = [
    ./hardware.nix
    ../common/core
    ../common/optional/nvidia.nix
    ./config.nix
  ];
}
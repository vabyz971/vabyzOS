{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/driver/nvidia.nix
    ../../modules/desktopManager/gnome
    ../../modules/core
  ];
}
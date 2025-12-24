{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/core
    ../../modules/driver/nvidia.nix
    ../../modules/desktopManager/gnome
  ];
}
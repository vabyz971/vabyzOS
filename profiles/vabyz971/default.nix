{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/desktopManager/gnome.nix
    ../../modules/core
  ];
}
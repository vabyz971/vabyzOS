{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/desktopManager/gnome
    ../../modules/core
  ];
}
{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/core
    ../../modules/desktopManager/gnome
  ];
}
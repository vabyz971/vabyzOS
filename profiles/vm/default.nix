{host, ... }: {

  imports = [
    ../../hosts/${host}
    ../../modules/core
  ];
}
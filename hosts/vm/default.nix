{ ... }: {
  imports = [
    ../hardware.nix
    ./bootloader.nix
    ./networking.nix
    ./i18n.nix
    ./service.nix
    ./packages.nix
    ./system.nix
  ];
}

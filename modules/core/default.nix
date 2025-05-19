{ inputs, ... }: {
  imports = [
    ./system.nix
    ./xserver.nix
    ./user.nix
    ./services.nix
    ./packages.nix
    ./fonts.nix
    ./stylix.nix
  ];
}

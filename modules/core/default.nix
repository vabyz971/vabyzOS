{ inputs, ... }: {
  imports = [
    ./system.nix
    ./xserver.nix
    ./network.nix
    ./user.nix
    ./services.nix
    ./packages.nix
    ./fonts.nix
    ./stylix.nix
  ];
}

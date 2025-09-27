{ ... }: {
  imports = [
    ./user.nix
    ./packages.nix
    ./flatpak.nix
    ./game.nix
    ./stylix.nix
    ./fonts.nix
    ./virtualisation.nix
  ];
}
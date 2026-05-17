{ ... }:
{
  imports = [
    ./boot.nix
    ./services.nix
    ./sops.nix
    ./users.nix
    ./pkgs.nix
    ./cachix.nix
  ];
}

{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    pkgs.android-tools
    pkgs.python315
    pkgs.nodejs_24
    pkgs.corepack_24
    pkgs.bun
    pkgs.openssl
    pkgs.nixfmt
    pkgs.nixd
    pkgs-unstable.zed-editor
    pkgs.luau # Pour crée des plugins noctalia V5
  ];

  programs.nix-ld.enable = true;
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    enableBashIntegration = true;
    enableZshIntegration = true;
    nix-direnv = {
      enable = true; # better than native direnv nix functionality - https://github.com/nix-community/nix-direnv
      package = pkgs.nix-direnv;
    };
  };
}

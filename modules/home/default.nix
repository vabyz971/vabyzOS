{ profile, ... }:
{
  imports = [
    ./git.nix
    ./kitty.nix
    ./zsh
    ./virtmanager.nix
  ];
}

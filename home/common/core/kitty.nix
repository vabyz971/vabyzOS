{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      name = "JetBrainsMono Nerd Font Regular";
      size = 12;
    };
  };
}

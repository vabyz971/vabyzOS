{
  pkgs,
  inputs,
  profile,
  ...
}:
let
  inherit (import ../../global/variables.nix) stylixImage;
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    image = stylixImage;
    polarity = "dark";
    opacity.terminal = 1.0;
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Regular";
      };
      sansSerif = {
        package = pkgs.roboto;
        name = "Roboto Regular";
      };
      serif = {
        package = pkgs.roboto;
        name = "Roboto Regular";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        terminal = 12;
      };
    };
  };
}

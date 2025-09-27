{ pkgs, inputs, profile, ... }: let
  inherit (import ../../global/variables.nix) stylixImage;
  
in {

  imports = [ inputs.stylix.nixosModules.stylix ];

  # Styling Options
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
        name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
    };
  };
}

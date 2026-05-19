{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      # 1. On retire "theme" et on pointe vers le fichier généré par Noctalia.
      # Le "?" au début est TRÈS important : il indique à Ghostty que le fichier est optionnel.
      # Cela évite que ton terminal crash si Noctalia n'a pas encore généré les couleurs au premier boot.
      "config-file" = "?~/.config/ghostty/themes/noctalia";

      # 2. Le reste de tes configurations graphiques
      "font-family" = "JetBrainsMono Nerd Font Mono";
      "font-size" = 12;
      "background-opacity" = 0.95;
      "window-padding-x" = 10;
      "window-padding-y" = 10;
      "confirm-close-surface" = false;
      "bell-features" = "no-audio";
    };
  };
}

{
  pkgs,
  config,
  lib,
  ...
}:
{

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    font = {
      name = "Liberation Sans Regular";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-theme = "Dracula";
        icon-theme = "Papirus-Dark";
        document-font-name = "Liberation Sans Medium 11";
        monospace-font-name = "Liberation Sans Medium 11";
        color-scheme = "prefer-dark";
      };
    };
  };
}

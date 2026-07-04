{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  # Ajout de adw-gtk3 aux paquets pour qu'il soit disponible
  home.packages = with pkgs; [
    adw-gtk3
  ];

  gtk = {
    enable = true;

    # CHANGEMENT ICI : On utilise adw-gtk3 comme thème pont pour GTK3
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    # Vous pouvez tout à fait garder vos icônes WhiteSur !
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
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
        gtk-theme = "adw-gtk3";
        icon-theme = "WhiteSur-dark";
        document-font-name = "Liberation Sans Medium 11";
        monospace-font-name = "Liberation Sans Medium 11";
        color-scheme = "prefer-dark";
      };
    };
  };
}

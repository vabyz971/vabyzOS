{ pkgs, ... }:

{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    enable-extension = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "lockkeys@vaina.lt"
      "trayIconsReloaded@selfmade.pl"
      "blur-my-shell@aunetx"
      "dash-to-dock@micxgx.gmail.com"
      "Vitals@CoreCoding.com"
      "tilingshell@ferrarodomenico.com"
      "logomenu@aryan_k"
    ];
  };


  # GNOME extensions are managed and configured by the program "Extensions" 
  # that comes with GNOME. Some of them can be installed with Nix, however they aren't enabled by default. 
  # To enable them the "Extensions" program can be used.

  home.packages = with pkgs.gnomeExtensions; [
    gnome-shell-extensions
    gnome-shell-extension-lockkeys
    tray-icons-reloaded
    blur-my-shell
    dash-to-dock
    vitals
    tilingshell
    logomenu
  ];
}

{
  pkgs,
  config,
  lib,
  ...
}:
{
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.enable = true;
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    # List extension activate
    "org/gnome/shell" = {
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gnome.gitlab.com"
        "Bluetooth-Battery-Meter@maniacx.github.com"
        "trayIconsReloaded@selfmade.pl"
        "add-to-desktop@tommimon.github.com"
        "blur-my-shell@aunetx"
        "dash-to-dock@micxgx.gmail.com"
        "Vitals@CoreCoding.com"
        "tilingshell@ferrarodomenico.com"
        "logomenu@aryan_k"
        "mediacontrols@cliffniff.github.com"
      ];
    };
  };

  # GNOME extensions are managed and configured by the program "Extensions"
  # that comes with GNOME. Some of them can be installed with Nix, however they aren't enabled by default.
  # To enable them the "Extensions" program can be used.

  environment.systemPackages = with pkgs.gnomeExtensions; [
    user-themes
    tray-icons-reloaded
    appindicator
    add-to-desktop
    blur-my-shell
    dash-to-dock
    vitals
    tiling-shell
    logo-menu
    media-controls
    bluetooth-battery-meter
  ];
}

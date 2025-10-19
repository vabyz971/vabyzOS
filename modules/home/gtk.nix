{ pkgs, config, lib,
 ... }:
let

in
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

    "org/gnome/desktop/background" = {
      show-desktop-icons = true;
    };

    # List extension activate 
    "org/gnome/shell" = {
      enabled-extensions = [
      "user-theme@gnome-shell-extensions.gcampax.github.com"
      "Bluetooth-Battery-Meter@maniacx.github.com"
      "trayIconsReloaded@selfmade.pl"
      "add-to-desktop@tommimon.github.com"
      "gtk4-ding@smedius.gitlab.com"
      "blur-my-shell@aunetx"
      "dash-to-dock@micxgx.gmail.com"
      "Vitals@CoreCoding.com"
      "tilingshell@ferrarodomenico.com"
      "logomenu@aryan_k"
      "lockkeys@vaina.lt"
      "mediacontrols@cliffniff.github.com"
      ];
    };
  };


  # GNOME extensions are managed and configured by the program "Extensions" 
  # that comes with GNOME. Some of them can be installed with Nix, however they aren't enabled by default. 
  # To enable them the "Extensions" program can be used.

  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    tray-icons-reloaded
    add-to-desktop
    gtk4-desktop-icons-ng-ding
    blur-my-shell
    dash-to-dock
    vitals
    tiling-shell
    logo-menu
    lock-keys
    media-controls
    bluetooth-battery-meter
  ];
}

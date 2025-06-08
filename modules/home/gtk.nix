{ pkgs, config,
 ... }:
let
  inherit (import ../../global/variables.nix) stylixImage;
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
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
      picture-url = "${stylixImage}";
      show-desktop-icons = true;
    };

    "org/gnome/desktop/default-applications/terminal" = {
      exec = "kitty";
    };

    "/org/gnome/nautilus/list-view" = {
      use-tree-view = true;
    };

    "/org/gnome/shell/extensions/Logo-menu/" = {
      menu-button-terminal = "kitty";
    };

    "/org/gnome/shell/extensions/dash-to-dock/" = {
      apply-custom-theme = true;
      autohide-in-fullscreen = true;
      background-opacity = "0,8";
      click-action = "minimize-or-overview";
      dance-urgent-applications = true;
      dash-max-icon-size = "32";
      disable-overview-on-startup = true;
      dock-position = "BOTTOM";
      show-favorites = true;
      show-mounts-network = true;
      show-trash = true;
      transparency-mode = "DYNAMIC";
    };


    "/org/gnome/shell/favorite-apps" = [
      "vivaldi-stable.desktop", 
      "re.sonny.Tangram.desktop",
      "discord.desktop",
      "codium.desktop",
      "kitty.desktop",
      "org.gnome.Nautilus.desktop",
      "io.missioncenter.MissionCenter.desktop",
      "org.gnome.World.Secrets.desktop",
      "org.gnome.Settings.desktop"
      ];


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

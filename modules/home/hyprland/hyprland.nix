{ inputs, config, pkgs, ... }: let
  inherit (import ../../../global/variables.nix) keyboardLayout stylixImage;
in {


  # Packages requis pour la config de hyprland 
  home.packages = with pkgs; [
    swww        # Depot : https://github.com/LGFae/swww
    hyprpolkitagent
    swaynotificationcenter  # Depot : https://github.com/ErikReider/SwayNotificationCenter
    # hyprland-qtutils      # needed for banners and ANR messages
  ];


  # systemd.user.targets.hyprland-session.Unit.Wants = [
  #   "xdg-desktop-autostart.target"
  # ];


  # Place Files Inside Home Directory
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
  };

   wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    xwayland = {
      enable = true;
   };
   settings = {
    exec-once = [
      "exec-once = dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user start hyprpolkitagent"
      "killall -q swww;sleep .5 && swww init"
      "sleep 1.5 && swww img ${stylixImage}"
    ];

    inputs = {
      kb_layout = "${keyboardLayout}";
      kb_options = [
        "grp:alt_caps_toggle"
        "caps:super"
      ];
    };

    env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
      ];
   };
  };
}
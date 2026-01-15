{
  inputs,
  pkgs,
  config,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # Must be false when using UWSM

    settings = {
      # Variables
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "vicinae toggle";

      # Auto-détection
      monitor = ",preferred,auto,auto";

      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "systemctl --user restart xdg-desktop-portal-gtk"
        "systemctl --user restart xdg-desktop-portal"
        "vicinae server"
      ];

      # Input (clavier/souris)
      input = {
        kb_layout = "fr"; # "us" pour QWERTY
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
        sensitivity = 0; # -1.0 à 1.0
      };

      # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      # Général
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
        allow_tearing = false;
      };

      # https://wiki.hypr.land/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 0.93;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = "3";
          passes = "2";
          vibrancy = "0.1696";
          new_optimizations = true;
        };
      };

      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hypr.land/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = "-1"; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
        middle_click_paste = true;
      };

      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = "3, horizontal, workspace";

      source = [
        "~/.config/hypr/noctalia/noctalia-colors.conf"
      ];
      plugin = {
        hyprspace = {
          overview_gaps = 5;
          workspace_gaps = 3;
          window_scale = 0.9;
        };
      };
    };

    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];
  };
}

{ ... }:
{
  programs.niri.settings = {
    input = {
      keyboard.xkb = {
        layout = "fr";
        variant = "azerty";
      };
      # Recommandé pour 60% : transformer Caps Lock en Ctrl ou Fn via DIP switch 3
      # ou via logiciel ici :
      # xkb.options = "caps:ctrl_modifier";
    };

    binds = {
      # --- Applications & Shell ---
      "Mod+Return".action.spawn = "kitty";
      "Mod+Q".action.close-window = { };
      "Mod+E".action.spawn = [
        "nautilus"
        "--new-window"
      ];
      "Mod+B".action.spawn = [
        "xdg-open"
        "https://"
      ];
      "Mod+Space" = {
        repeat = false;
        action.spawn = [
          "vicinae"
          "toggle"
        ];
      };
      "Mod+Shift+L".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "lockScreen"
        "lock"
      ];

      # Binds spécifiques Noctalia Shell (IPC)
      "Alt+Space".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "launcher"
        "toggle"
      ];
      "Mod+Shift+D".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "controlCenter"
        "toggle"
      ];
      "Mod+N".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "notifications"
        "toggle"
      ];
      "Mod+Shift+S".action.spawn = [
        "niri"
        "msg"
        "action"
        "screenshot"
      ];

      # --- Navigation Colonne/Fenêtre (Style Vim pour 60%) ---
      "Mod+J".action.focus-column-left = { };
      "Mod+L".action.focus-column-right = { };
      "Mod+I".action.focus-window-up = { };
      "Mod+K".action.focus-window-down = { };

      # Déplacement (Mod + Ctrl + HJKL)
      "Mod+Ctrl+J".action.move-column-left = { };
      "Mod+Ctrl+L".action.move-column-right = { };
      "Mod+Ctrl+I".action.move-window-up = { };
      "Mod+Ctrl+K".action.move-window-down = { };

      # --- Gestion des Workspaces (Optimisé AZERTY sans Maj) ---
      "Mod+ampersand".action.focus-workspace = 1;
      "Mod+eacute".action.focus-workspace = 2;
      "Mod+quotedbl".action.focus-workspace = 3;
      "Mod+apostrophe".action.focus-workspace = 4;
      "Mod+parenleft".action.focus-workspace = 5;
      "Mod+egrave".action.focus-workspace = 6;
      "Mod+minus".action.focus-workspace = 7;
      "Mod+underscore".action.focus-workspace = 8;
      "Mod+ccedilla".action.focus-workspace = 9;
      "Mod+agrave".action.focus-workspace = 10;

      # Déplacer vers workspace (Mod + Ctrl + Symboles)
      "Mod+Shift+ampersand".action.move-window-to-workspace = 1;
      "Mod+Shift+eacute".action.move-window-to-workspace = 2;
      "Mod+Shift+quotedbl".action.move-window-to-workspace = 3;
      "Mod+Shift+apostrophe".action.move-window-to-workspace = 4;
      "Mod+Shift+parenleft".action.move-window-to-workspace = 5;
      "Mod+Shift+egrave".action.move-window-to-workspace = 6;
      "Mod+Shift+minus".action.move-window-to-workspace = 7;
      "Mod+Shift+underscore".action.move-window-to-workspace = 8;
      "Mod+Shift+ccedilla".action.move-window-to-workspace = 9;
      "Mod+Shift+agrave".action.move-window-to-workspace = 10;
      #... répéter pour les autres chiffres

      # --- Mise en page (Layout) ---
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };
      "Mod+C".action.center-column = { };
      "Mod+S".action.switch-preset-column-width = { };
      "Mod+Comma".action.consume-or-expel-window-left = { };
      "Mod+Period".action.consume-or-expel-window-right = { };

      # --- Système & Médias ---
      "XF86AudioRaiseVolume".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "volume"
        "increase"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "volume"
        "decrease"
      ];
      "XF86AudioMute".action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
      "Print".action.screenshot-screen = {
        show-pointer = false;
      };
    };
  };
}

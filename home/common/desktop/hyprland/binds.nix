{ ... }:
{
  # Raccourci pour clavier AZERTY
  # ================= HYPRLAND =================
  wayland.windowManager.hyprland.settings = {
    bind = [

      # ================= NOCTALIA =================
      "ALT, Space, exec, qs -c noctalia-shell ipc call launcher toggle"
      "$mod ALT, L, exec, qs -c noctalia-shell ipc call sessionMenu lockAndSuspend"
      "$mod ,X, exec, qs -c noctalia-shell ipc call sessionMenu toggle"
      "$mod CTRL, R, exec, qs -c noctalia-shell ipc call screenRecorder toggle"

      # ============= BIND GENERAL =============
      "$mod, A, exec, $terminal"
      "$mod, Q, killactive,"
      "$mod, B, exec, xdg-open https://"
      "$mod, E, exec, nautilus --new-window"
      "$mod, F, togglefloating,k"
      "$mod, P, pseudo, # dwindle"
      "$mod, S, togglesplit, # dwindle"
      "$mod, Space, exec, vicinae toggle"
      "$mod, TAB, exec, overview:toggle"

      "$mod SHIFT, W, exec, hyprshot -m window -o ~/Pictures/Screenshots/"
      "$mod SHIFT, S, exec, hyprshot -m region -o ~/Pictures/Screenshots/"
      ", PRINT, exec, hyprshot -m output -o ~/Pictures/Screenshots/"

      # ============= MOVE FOCUS WINDOWS =============
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # ============= WORKSPACE SWITCH =============
      "$mod, ampersand, workspace, 1"
      "$mod, eacute, workspace, 2"
      "$mod, quotedbl, workspace, 3"
      "$mod, apostrophe, workspace, 4"
      "$mod, parenleft, workspace, 5"
      "$mod, egrave, workspace, 6"
      "$mod, minus, workspace, 7"
      "$mod, underscore, workspace, 8"
      "$mod, ccedilla, workspace, 9"
      "$mod, agrave, workspace, 10"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # ============= WORKSPACE MOVE APP =============
      "$mod SHIFT, ampersand, movetoworkspace, 1"
      "$mod SHIFT, eacute, movetoworkspace, 2"
      "$mod SHIFT, quotedbl, movetoworkspace, 3"
      "$mod SHIFT, apostrophe, movetoworkspace, 4"
      "$mod SHIFT, parenleft, movetoworkspace, 5"
      "$mod SHIFT, egrave, movetoworkspace, 6"
      "$mod SHIFT, minus, movetoworkspace, 7"
      "$mod SHIFT, underscore, movetoworkspace, 8"
      "$mod SHIFT, ccedilla, movetoworkspace, 9"
      "$mod SHIFT, agrave, movetoworkspace, 10"

      # ============= MULTIMEDIA KEYS =============
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

      # ============= MULTIMEDIA KEYS =============
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"

    ];

    # ============= MOVE/RESIZE WINDOWS =============
    bindm = [
      "$modifier, mouse:272, movewindow"
      "$modifier, mouse:273, resizewindow"
    ];
  };
}

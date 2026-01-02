{ ... }:
{
  # Raccourci pour clavier AZERTY


  # ================= NOCTALIA =================
    bindNoctalia = [
      "$modifier,V, Noctalia Clipboard, exec, qs -c noctalia-shell ipc call launcher clipboard"
      "$modifier ALT,L, Noctalia Lock Screen, exec, qs -c noctalia-shell ipc call sessionMenu lockAndSuspend"
      "$modifier,X, Noctalia Power Menu, exec, qs -c noctalia-shell ipc call sessionMenu toggle"
      "$modifier CTRL,R, Noctalia Screen Recorder, exec, qs -c noctalia-shell ipc call screenRecorder toggle"
    ];

  # ================= HYPRLAND =================
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = bindNoctalia ++ [


      # ============= BIND GENERAL =============
      "$mainMod, A, exec, $terminal"
      "$mainMod, Q, killactive,"
      "$mainMod, B, exec, $browser"
      "$mainMod, E, exec, $fileManager"
      "$mainMod, V, togglefloating,k"
      "$mainMod, P, pseudo, # dwindle"
      "$mainMod, J, togglesplit, # dwindle"
      "$mainMod, Space, exec, vicinae toggle"
      "$mainMod, TAB, exec, overview:toggle"

      # ============= MOVE/RESIZE WINDOWS =============
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"

      # ============= MOVE FOCUS WINDOWS =============
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # ============= WORKSPACE SWITCH =============
      "$mainMod SHIFT, ampersand, movetoworkspace, 1"
      "$mainMod, eacute, workspace, 2"
      "$mainMod, quotedbl, workspace, 3"
      "$mainMod, apostrophe, workspace, 4"
      "$mainMod, parenleft, workspace, 5"
      "$mainMod, egrave, workspace, 6"
      "$mainMod, minus, workspace, 7"
      "$mainMod, underscore, workspace, 8"
      "$mainMod, ccedilla, workspace, 9"
      "$mainMod, agrave, workspace, 10"

      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # ============= WORKSPACE MOVE APP =============
      "$mainMod SHIFT, ampersand, movetoworkspace, 1"
      "$mainMod SHIFT, eacute, movetoworkspace, 2"
      "$mainMod SHIFT, quotedbl, movetoworkspace, 3"
      "$mainMod SHIFT, apostrophe, movetoworkspace, 4"
      "$mainMod SHIFT, parenleft, movetoworkspace, 5"
      "$mainMod SHIFT, egrave, movetoworkspace, 6"
      "$mainMod SHIFT, minus, movetoworkspace, 7"
      "$mainMod SHIFT, underscore, movetoworkspace, 8"
      "$mainMod SHIFT, ccedilla, movetoworkspace, 9"
      "$mainMod SHIFT, agrave, movetoworkspace, 10"

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
    ]
  };
}

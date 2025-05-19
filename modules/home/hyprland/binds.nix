{host, ... }: let
  inherit
    (import ../../../global/variables.nix)
    browser
    terminal
    fileSystem
    ;
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
      "$mod,T,exec,${terminal}"
      "$mod,B,exec,${browser}"
      "$mod,E,exec,${fileSystem}"
      "$mod SHIFT,Return,exec,fuzzel"
      "$mod,Q,killactive,"
      "$mod,P,pseudo,"
      "$mod,F,fullscreen,"
      "$mod SHIFT,F,togglefloating,"
      "$mod ALT,F,workspaceopt, allfloat"
      "$mod SHIFT,C,exit,"
      "$mod SHIFT,left,movewindow,l"
      "$mod SHIFT,right,movewindow,r"
      "$mod SHIFT,up,movewindow,u"
      "$mod SHIFT,down,movewindow,d"
      "$mod SHIFT,h,movewindow,l"
      "$mod SHIFT,l,movewindow,r"
      "$mod SHIFT,k,movewindow,u"
      "$mod SHIFT,j,movewindow,d"
      "$mod ALT, left, swapwindow,l"
      "$mod ALT, right, swapwindow,r"
      "$mod ALT, up, swapwindow,u"
      "$mod ALT, down, swapwindow,d"
      "$mod ALT, 43, swapwindow,l"
      "$mod ALT, 46, swapwindow,r"
      "$mod ALT, 45, swapwindow,u"
      "$mod ALT, 44, swapwindow,d"
      "$mod,left,movefocus,l"
      "$mod,right,movefocus,r"
      "$mod,up,movefocus,u"
      "$mod,down,movefocus,d"
      "$mod SHIFT,SPACE,movetoworkspace,special"
      "$mod,SPACE,togglespecialworkspace"
      "$mod CONTROL,right,workspace,e+1"
      "$mod CONTROL,left,workspace,e-1"
      "$mod,mouse_down,workspace, e+1"
      "$mod,mouse_up,workspace, e-1"
      "ALT,Tab,cyclenext"
      "ALT,Tab,bringactivetotop"
      ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
      ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
    ];
  };
}

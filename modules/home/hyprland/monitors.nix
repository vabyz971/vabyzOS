{ ... }: let 


  display = "preferred";
  resolution = "1280x720";
  framerate = "60";
  scale = "1";
in {

  wayland.windowManager.hyprland = {
    extraConfig = "
      monitor=,${display},${resolution}@${framerate},${scale}
      ";
  };
}
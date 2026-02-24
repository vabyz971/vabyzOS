{ ... }:
{
  programs.niri.settings = {
    window-rules = [
      {
        matches = [ { app-id = "org.keepassxc.KeePassXC"; } ];
        block-out-from = "screencast";
      }
      {
        # Règles visuelles générales
        geometry-corner-radius = {
          top-left = 5.0;
          top-right = 5.0;
          bottom-left = 5.0;
          bottom-right = 5.0;
        };
        clip-to-geometry = true;
      }
    ];
    layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-wallpaper*"; }
        ];
        place-within-backdrop = true;
      }
    ];
    layout = {
      background-color = "transparent";
    };
    overview = {
      workspace-shadow.enable = false;
    };
  };
}

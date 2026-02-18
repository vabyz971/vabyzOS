{ ... }:
{
  programs.niri.settings = {
    window-rules = [
      {
        matches = [
          { app-id = "firefox"; }
          { app-id = "vivaldi"; }
        ];
        default-column-width = {
          proportion = 0.66;
        };
      }
      {
        matches = [ { app-id = "org.keepassxc.KeePassXC"; } ];
        block-out-from = "screen-capture";
      }
      {
        # Règles visuelles générales
        geometry-corner-radius = {
          top-left = 0.0;
          top-right = 0.0;
          bottom-left = 0.0;
          bottom-right = 0.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}

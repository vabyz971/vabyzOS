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
          top-left = 10.0;
          top-right = 10.0;
          bottom-left = 10.0;
          bottom-right = 10.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}

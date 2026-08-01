{ ... }:
{
  programs.niri.settings = {
    prefer-no-csd = true;
    window-rules = [
      {
        matches = [ { app-id = "org.keepassxc.KeePassXC"; } ];
        block-out-from = "screencast";
      }
      {
        matches = [ { app-id = "dev.noctalia.Noctalia.Settings"; } ];
        open-floating = true;
        default-column-width = {
          fixed = 1080;
        };
        default-window-height = {
          fixed = 920;
        };
      }
      {
        # Règles visuelles générales
        geometry-corner-radius = {
          top-left = 15.0;
          top-right = 15.0;
          bottom-left = 15.0;
          bottom-right = 15.0;
        };
        clip-to-geometry = true;
      }
    ];
    layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-wallpaper"; }
        ];
        place-within-backdrop = true;
      }
    ];
    layout = {
      background-color = "transparent";
      border.width = 2;
      focus-ring.width = 2;
    };
    overview = {
      workspace-shadow.enable = false;
    };
  };
}

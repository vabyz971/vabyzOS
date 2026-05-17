{ inputs, pkgs, ... }:
{
  # DOC : https://github.com/sodiboo/niri-flake/blob/main/docs.md#programsnirisettings

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    useNautilus = true;
    # Skip les test uniter pour la detection de GPU car il n'est pas présent en sandbox
    package = pkgs.niri-unstable;
  };

  environment.systemPackages = with pkgs; [
    gpu-screen-recorder
    xwayland-satellite
  ];
}

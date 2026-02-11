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
    xwayland-satellite
  ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Polkit et agent d'authentification
  security.polkit.enable = true;
}

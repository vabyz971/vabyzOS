{ inputs, pkgs, ... }:
let
  inherit (import ../../../../../global/variables.nix) host;
in
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

    # pkgs pour OCR et traduction utiliser dans plugins noctalia
    tesseract
    translate-shell
  ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = if host.type == "laptop" then false else true;

  # Polkit et agent d'authentification
  security.polkit.enable = true;
}

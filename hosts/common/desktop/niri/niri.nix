{ inputs, ... }:

{

  # DOC : https://github.com/sodiboo/niri-flake/blob/main/docs.md#programsnirisettings

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  # Services nécessaires pour Noctalia Shell
  # networking.networkmanager.enable = true;
  # hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Polkit et agent d'authentification
  security.polkit.enable = true;
}

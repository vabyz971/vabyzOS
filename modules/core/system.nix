{host, ...}: let
  inherit (import ../../global/variables.nix) consoleKeyMap i18nLocalLanguage stateVersion;
in {
  nix = {
    settings = {
      download-buffer-size = 250000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "${i18nLocalLanguage}";

  environment.variables = {
    HOZIZONOS_VERSION = "0.1";
    HOZIZONOS = "true";
  };

  console.keyMap = "${consoleKeyMap}";
  system.stateVersion = "${stateVersion}"; # Do not change!
}

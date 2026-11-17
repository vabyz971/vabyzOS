# Réglages de la machine « vm » — généré par install.sh, modifiable à la main.
# Valeurs par défaut et description des champs : lib/default.nix (defaultSettings).
{
  hostName = "vm-vabyz";
  username = "vabyz971";
  gitUsername = "vabyz971";
  gitEmail = "vabyz971@gmail.com";

  locale = "fr_FR.UTF-8";
  timezone = "America/Toronto";
  keyboardLayout = "fr,us";
  keyboardOptions = "grp:alt_shift_toggle";

  isLaptop = false;
  passwordMode = "sops";

  # Modules de modules/optional/
  modules = [
    "appimage"
    "pkgs-store"
    "vivaldi"
    "zen-browser"
    "fonts"
    "gnome-app"
    "nautilus"
    "noctalia"
    "noctalia-greeter"
    "niri"
    "vm-guest"
  ];

  # Modules home-manager de home/optional/
  homeModules = [
    "niri"
    "noctalia"
    "nautilus"
    "virtmanager"
  ];
}

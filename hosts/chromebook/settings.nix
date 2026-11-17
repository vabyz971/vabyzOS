# Réglages de la machine « chromebook » — généré par install.sh, modifiable à la main.
# Valeurs par défaut et description des champs : lib/default.nix (defaultSettings).
{
  hostName = "chromebook-vabyz";
  username = "vabyz971";
  gitUsername = "vabyz971";
  gitEmail = "vabyz971@gmail.com";

  locale = "fr_FR.UTF-8";
  timezone = "America/Toronto";
  keyboardLayout = "fr,us";
  keyboardOptions = "grp:alt_shift_toggle";

  isLaptop = true;
  passwordMode = "sops";

  # Modules de modules/optional/
  modules = [
    "zen-browser"
    "fonts"
    "gnome-app"
    "yazi"
    "pkgs-store"
    "noctalia"
    "noctalia-greeter"
    "niri"
    "blip"
    "ssh"
  ];

  # Modules home-manager de home/optional/
  homeModules = [
    "niri"
    "noctalia"
    "nautilus"
  ];
}

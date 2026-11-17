# Réglages de la machine « workstation » — généré par install.sh, modifiable à la main.
# Valeurs par défaut et description des champs : lib/default.nix (defaultSettings).
{
  hostName = "workstation-vabyz";
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
    "nvidia"
    "zen-kernel"
    "appimage"
    "vivaldi"
    "zen-browser"
    "development"
    "docker"
    "fonts"
    "game"
    "gnome-app"
    "nautilus"
    "pkgs-store"
    "qemu"
    "openrgb"
    "noctalia"
    "noctalia-greeter"
    "niri"
    "blip"
  ];

  # Modules home-manager de home/optional/
  homeModules = [
    "niri"
    "noctalia"
    "nautilus"
    "virtmanager"
  ];
}

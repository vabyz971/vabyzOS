# Helpers d'imports absolus depuis la racine du flake.
# Fichier statique (versionné) : les choix par machine sont dans hosts/<nom>/settings.nix.
inputs: rec {
  core = inputs.self + "/modules/core";
  homeCore = inputs.self + "/home/core";

  mod = name: inputs.self + "/modules/optional/${name}.nix";
  mods = names: map mod names;

  # Gère les fichiers .nix ET les dossiers (ex: home/optional/niri/).
  homeMod =
    name:
    if builtins.pathExists (inputs.self + "/home/optional/${name}.nix") then
      inputs.self + "/home/optional/${name}.nix"
    else
      inputs.self + "/home/optional/${name}";
  homeMods = names: map homeMod names;

  # Valeurs par défaut des réglages d'une machine (surchargées par hosts/<nom>/settings.nix).
  defaultSettings = {
    username = "vabyz971";
    gitUsername = "vabyz971";
    gitEmail = "";
    locale = "fr_FR.UTF-8";
    timezone = "America/Toronto";
    keyboardLayout = "fr,us";
    keyboardOptions = "grp:alt_shift_toggle";
    isLaptop = false;
    # "sops"  : hash du mot de passe dans secrets/secrets.yaml (même mot de passe partout)
    # "local" : hash dans /var/lib/vabyzos/password.hash, écrit par install.sh (hors git)
    passwordMode = "sops";
    modules = [ ];
    homeModules = [ ];
  };

  # Machines = dossiers de hosts/ contenant un settings.nix.
  hostNames = builtins.attrNames (
    inputs.nixpkgs.lib.filterAttrs (
      name: type: type == "directory" && builtins.pathExists (inputs.self + "/hosts/${name}/settings.nix")
    ) (builtins.readDir (inputs.self + "/hosts"))
  );

  hostSettings =
    hostname:
    defaultSettings
    // {
      inherit hostname;
      hostName = "${hostname}-vabyz";
    }
    // import (inputs.self + "/hosts/${hostname}/settings.nix");
}

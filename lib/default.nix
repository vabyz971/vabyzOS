# Helpers d'imports absolus depuis la racine du flake.
# Fichier statique (versionné) : ne dépend pas de install.sh,
# contrairement à variables.nix qui est généré.
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
}

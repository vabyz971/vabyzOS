# Fichier généré automatiquement par install.sh
inputs: rec {
  username = "vabyz971";

  gitUsername = "vabyz971";
  gitEmail = "vabyz971@gmail.com";
  i18nLocalLanguage = "fr_FR.UTF-8";

  basePath = path: inputs.self + "/${path}";

  core = inputs.self + "/modules/core";
  homeCore = inputs.self + "/home/core";

  mod = name: inputs.self + "/modules/optional/${name}.nix";
  mods = names: map mod names;

  homeMod =
    name:
    if builtins.pathExists (inputs.self + "/home/optional/${name}.nix") then
      inputs.self + "/home/optional/${name}.nix"
    else
      inputs.self + "/home/optional/${name}";
  homeMods = names: map homeMod names;

  profile = "workstation";
  host = "desktop";
}

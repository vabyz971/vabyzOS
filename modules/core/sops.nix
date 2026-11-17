{
  inputs,
  lib,
  settings,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";

    # Mot de passe de l'utilisateur principal (uniquement en passwordMode = "sops")
    secrets = lib.mkIf (settings.passwordMode == "sops") {
      "secret/users/${settings.username}" = {
        neededForUsers = true;
      };
    };
  };
}

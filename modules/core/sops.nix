{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      # Secret pour utilisateur principal
      "secret/users/vabyz971" = {
        neededForUsers = true;
      };

      # Secret pour un futur utilisateur (exemple)
      # "secret/users/mika" = {
      #   neededForUsers = true;
      # };
    };
  };
}

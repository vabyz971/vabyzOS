{ inputs, ...}:
let
  inherit (import ../../../../global/variables.nix) username;
in
{

  imports = [inputs.sops-nix.nixosModules.sops];

  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
}
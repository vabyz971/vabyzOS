# desc: Serveur SSH (clés uniquement) pour administrer la machine à distance
# Clés autorisées : tous les fichiers *.pub de ssh-keys/ (une clé publique par poste client).
{ lib, settings, ... }:
let
  keyDir = ../../ssh-keys;
  keyFiles = builtins.filter (lib.hasSuffix ".pub") (builtins.attrNames (builtins.readDir keyDir));
in
{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ settings.username ];
    };
  };

  users.users.${settings.username}.openssh.authorizedKeys.keys = map (
    f: lib.fileContents (keyDir + "/${f}")
  ) keyFiles;
}

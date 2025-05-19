{ host, ... }:
let
  inherit (import ../../global/variables.nix) gitUsername gitEmail;
in
{
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
}

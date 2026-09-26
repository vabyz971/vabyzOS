{ inputs, helpers, pkgs, ... }:
{
  imports = [
    inputs.blip.nixosModules.default
    (helpers.mod "portals")
  ];
  programs.blip = {
    enable = true;
    # Évite le `default` upstream qui utilise `pkgs.system` (déprécié).
    package = inputs.blip.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}

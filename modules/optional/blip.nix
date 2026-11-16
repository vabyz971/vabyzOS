{
  inputs,
  helpers,
  pkgs,
  ...
}:
{
  imports = [
    inputs.blip.nixosModules.default
    (helpers.mod "portals")
  ];
  programs.blip = {
    enable = true;
    package = inputs.blip.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}

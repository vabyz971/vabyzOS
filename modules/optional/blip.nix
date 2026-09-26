{ Inputs, ... }:
{
  imports = [ Inputs.blip.nixosModules.default ];
  programs.blip.enable = true;
}

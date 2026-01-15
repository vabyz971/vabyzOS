{
  inputs,
  ...
}:
let
  inherit (import ../../../../global/variables.nix) keyboardLayout;
in
{
  services.xserver.xkb = {
    layout = "${keyboardLayout}";
    variant = "";
  };

  imports = [ inputs.silentSDDM.nixosModules.default ];
  programs.silentSDDM = {
    enable = true;
    theme = "default";
    # settings = { ... }; see example in module
  };
}

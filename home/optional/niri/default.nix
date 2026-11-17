# desc: Config Niri (raccourcis, règles de fenêtres, thème GTK)
{ inputs, ... }:

{
  imports = [
    # Importation du module de configuration Niri
    inputs.niri.homeModules.config
    ./niri.nix
    ./niri-binds.nix
    ./niri-window-rules.nix
    ./gtk.nix
  ];
}

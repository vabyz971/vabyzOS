{ profile, ... }:
{
  imports = [
    ./noctalia
    ./git.nix
    ./kitty.nix
    ./zsh
    ./virtmanager.nix
  ] ++ (
    if profile == "gnome" then [ ./gtk.nix] else []
  );
}

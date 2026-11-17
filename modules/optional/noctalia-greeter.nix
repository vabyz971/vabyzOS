# desc: Écran de connexion Noctalia
{
  pkgs,
  inputs,
  settings,
  ...
}:

{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      keyboard.layout = "fr";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
    };
  };

  # Synchronisation avec noctalia
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        var allowedUsers = [ "${settings.username}" ];

        if (action.id == "org.noctalia.greeter.sync-appearance" &&
            action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
            action.lookup("user") == "root" &&
            subject.local && subject.active &&
            allowedUsers.indexOf(subject.user) >= 0) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}

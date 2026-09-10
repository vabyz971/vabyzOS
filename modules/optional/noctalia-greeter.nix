{
  pkgs,
  ...
}:

{
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      cursor.size = 24;
      keyboard.layout = "fr";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };

  # Synchronisation avec noctalia
  security.polkit = {
    enablePkexecWrapper = true;
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        var allowedUsers = ["alice"];

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

{ pkgs, lib, inputs, variables, ... }:

let
  userRegistry = {
    # Premier utilisateur
    vabyz971 = {
      description = "Principal";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "adbusers"
        "docker"
        "libvirtd"
        "i2c"
      ];
      isNormalUser = true;
      shell = pkgs.zsh;
      homeModules = [
        (variables.basePath "home/core")

        (variables.basePath "home/optional/niri")
        (variables.basePath "home/optional/noctalia.nix")
        (variables.basePath "home/optional/nautilus.nix")
        (variables.basePath "home/optional/vicinae.nix")
        (variables.basePath "home/optional/virtmanager.nix")
      ];
    };
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users = lib.mapAttrs (username: userConfig: {
    inherit (userConfig) description isNormalUser extraGroups;
    # Utilise sops-nix ici pour associer un mot de passe chiffré si besoin :
    # passwordFile = config.sops.secrets."password-${username}".path;
  }) userRegistry;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; inherit variables; };

    # On boucle sur notre registre pour injecter les modules HM correspondants
    users = lib.mapAttrs (username: userConfig: {
      imports = userConfig.homeModules;

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.11"; # Définit l'ancre de version pour tous profils
      };
    }) userRegistry;
  };
}

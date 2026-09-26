{
  pkgs,
  lib,
  inputs,
  variables,
  helpers,
  config,
  ...
}:

let
  userRegistry = {
    # Utilisateur 1
    vabyz971 = {
      description = "vabyz971";
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
      homeModules = [ helpers.homeCore ] ++ helpers.homeMods [ "niri" "noctalia" "nautilus" "virtmanager" ];
    };

    # Exemple d'un deuxième utilisateur
    # mika = {
    #   description = "Mikael";
    #   extraGroups = [ "wheel" "networkmanager" "video" ];
    #   isNormalUser = true;
    #   shell = pkgs.zsh;
    #   homeModules = [ helpers.homeCore ];
    # };
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.mutableUsers = false;

  # Génération dynamique des utilisateurs NixOS
  users.users = lib.mapAttrs (username: userConfig: {
    inherit (userConfig)
      description
      isNormalUser
      extraGroups
      shell
      ;

    # Le chemin du mot de passe est dynamique !
    hashedPasswordFile = config.sops.secrets."secret/users/${username}".path;

  }) userRegistry;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit variables;
      inherit helpers;
    };

    users = lib.mapAttrs (username: userConfig: {
      imports = userConfig.homeModules;

      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "26.05"; # Définit l'ancre de version pour tous profils
      };
    }) userRegistry;
  };
}

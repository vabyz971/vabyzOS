{
  pkgs,
  lib,
  inputs,
  variables,
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
      homeModules = [
        (variables.basePath "home/core")
        (variables.basePath "home/optional/niri")
        (variables.basePath "home/optional/noctalia.nix")
        (variables.basePath "home/optional/nautilus.nix")
        (variables.basePath "home/optional/vicinae.nix")
        (variables.basePath "home/optional/virtmanager.nix")
      ];
    };

    # Exemple d'un deuxième utilisateur
    # mika = {
    #   description = "Mikael";
    #   extraGroups = [ "wheel" "networkmanager" "video" ];
    #   isNormalUser = true;
    #   shell = pkgs.zsh;
    #   homeModules = [ (variables.basePath "home/core") ];
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
    };

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

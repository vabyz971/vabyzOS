{
  pkgs,
  lib,
  inputs,
  settings,
  helpers,
  config,
  ...
}:

let
  userRegistry = {
    # Utilisateur principal (défini dans hosts/<nom>/settings.nix)
    ${settings.username} = {
      description = settings.username;
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
        helpers.homeCore
      ]
      ++ helpers.homeMods settings.homeModules;
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

    # sops : secret chiffré du dépôt / local : fichier écrit par install.sh (hors git)
    hashedPasswordFile =
      if settings.passwordMode == "sops" then
        config.sops.secrets."secret/users/${username}".path
      else
        "/var/lib/vabyzos/password.hash";

  }) userRegistry;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit settings;
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

{
  description = "HorizonOS by vabyz971";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Specify the source of Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.Nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let

      # Définition des configuration disponible
      configuration = {
        "gnome" = {
          system = "x86_64-linux";
          host = "desktop";
          profile = "gnome";
          modules = [
            ./hosts/desktop
            ./modules/core
            ./modules/driver/nvidia.nix
            ./modules/desktopManager/gnome.nix
          ];
        };
        "vm" = {
          system = "x86_64-linux";
          host = "vm";
          profile = "vm";
          modules = [
            ./hosts/vm
            ./modules/core
            ./modules/desktopManager/niri.nix
          ];
        };
      };

      # Fonction de création de configuration Nixos
      mkNixosConfig =
        {
          configName,
          system,
          host,
          profile,
          modules,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            inherit profile;
            inherit host;
            configName = configName;
          };

          modules = modules;
        };
    in
    {

      # Fonction générale a tout les configuration
      nixosConfigurations = builtins.mapAttrs (
        configName: cfg:
        mkNixosConfig (
          {
            inherit configName;
          }
          // cfg
        )
      ) configuration;
    };
}

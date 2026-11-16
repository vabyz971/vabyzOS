{
  description = "VabyzOS by vabyz971";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    blip = {
      url = "github:blip-net/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # import (et non legacyPackages) pour que allowUnfree s'applique aussi à unstable
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      variables = import ./variables.nix inputs;
      helpers = import ./lib inputs;

      # hostname = nom de la sortie du flake (utilisé par autoUpgrade et les alias nh)
      mkHost =
        hostname:
        {
          isLaptop ? false,
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              pkgs-unstable
              variables
              helpers
              hostname
              isLaptop
              ;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/${hostname}
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        workstation = mkHost "workstation" { };
        vm = mkHost "vm" { };
        chromebook = mkHost "chromebook" {
          isLaptop = true;
          extraModules = [ inputs.disko.nixosModules.disko ];
        };
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}

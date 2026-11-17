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
      helpers = import ./lib inputs;

      # Une machine = un dossier hosts/<nom>/ avec settings.nix (généré par install.sh),
      # hardware.nix et default.nix (réglages propres à la machine).
      mkHost =
        hostname:
        let
          settings = helpers.hostSettings hostname;
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              pkgs-unstable
              helpers
              settings
              ;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/${hostname}
            ./hosts/${hostname}/hardware.nix
            helpers.core
          ]
          ++ helpers.mods settings.modules;
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs helpers.hostNames mkHost;

      formatter.${system} = pkgs.nixfmt-tree;
    };
}

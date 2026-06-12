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
    noctalia-greeter.url = "github:noctalia-dev/noctalia-greeter";
    noctalia.url = "github:noctalia-dev/noctalia";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      globalVars = import ./variables.nix inputs;

    in
    {
      nixosConfigurations = {
        workstation = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-unstable;
            variables = globalVars;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            inputs.home-manager.nixosModules.home-manager
            ./hosts/workstation
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-unstable;
            variables = globalVars;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            inputs.home-manager.nixosModules.home-manager
            ./hosts/vm
          ];
        };
        chromebook = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-unstable;
            variables = globalVars;
          };
          modules = [
            { nixpkgs.hostPlatform = system; }
            inputs.home-manager.nixosModules.home-manager
            inputs.disko.nixosModules.disko
            ./hosts/chromebook
          ];
        };
      };
    };
}

{
  description = "VabyzOS by vabyz971";

  # Configuration du cache au niveau du Flake
  nixConfig = {
      extra-substituters = [
        "https://niri.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    noctalia = {
        url = "github:noctalia-dev/noctalia-shell";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    vicinae = {
        url = "github:vicinaehq/vicinae";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          specialArgs = { inherit inputs pkgs-unstable; variables = globalVars; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            
            inputs.home-manager.nixosModules.home-manager

            ./hosts/workstation
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable; variables = globalVars; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            
            inputs.home-manager.nixosModules.home-manager

            ./hosts/vm
          ];
        };
        chromebook = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable; variables = globalVars; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            
            inputs.home-manager.nixosModules.home-manager

            ./hosts/chromebook
          ];
        };
      };
    };
}

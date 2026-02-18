{
  description = "Configuration nixos by vabyz971";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Specify the source of Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    vicinae.url = "github:vicinaehq/vicinae";

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
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

      # Configuration de base Home Manager
      homeManagerBase = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";

      };

    in
    {
      nixosConfigurations = {
        vabyz971 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/desktop
            ./hosts/users/vabyz971.nix

            home-manager.nixosModules.home-manager
            (
              homeManagerBase
              // {
                home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
                home-manager.users = {
                  vabyz971 = import ./home/users/vabyz971.nix;
                };
              }
            )
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/vm
            ./hosts/users/vabyz971.nix

            home-manager.nixosModules.home-manager
            (
              homeManagerBase
              // {
                home-manager.users = {
                  vabyz971 = import ./home/users/vabyz971.nix;
                };
              }
            )
          ];
        };
      };
    };
}

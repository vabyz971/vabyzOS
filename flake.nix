{
  description = "Configuration nixos by vabyz971";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Specify the source of Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let

      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

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
          inherit system;
          modules = [
            ./hosts/desktop
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
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/vm

            home-manager.nixosModule.home-manager
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

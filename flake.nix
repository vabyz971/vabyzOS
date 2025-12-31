{
  description = "Configuration nixos by vabyz971";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Specify the source of Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
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
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/desktop
            ./hosts/users/vabyz971.nix

            home-manager.nixosModules.home-manager
            (
              homeManagerBase
              // {
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users = {
                  vabyz971 = import ./home/users/vabyz971.nix;
                };
              }
            )
          ];
        };
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
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

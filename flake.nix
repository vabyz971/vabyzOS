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
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      configuration = {
        "gnome" = {
          system = "x86_64-linux";
          host = "desktop";
          profile = "vabyz971";
          modules = [ ./profiles/vabyz971 ];
        };
        "vm" = {
          system = "x86_64-linux";
          host = "vm";
          profile = "vm";
          modules = [ ./profiles/vm ];
        };
      };

      mkNixosConfig = { configName, system, host, profile, modules}:
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
    in {
      nixosConfigurations = builtins.mapAttrs (configName: cfg: mkNixosConfig ({
        inherit configName;
      } // cfg)
      ) configuration;
    };
}

{
  description = "HorizonOS by vabyz971";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:nix-community/stylix/release-25.05";
  };

  outputs = { nixpkgs, ...} @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      host = "desktop";
      profile = "vabyz971";
    in
    {
      nixosConfigurations = {
      vabyz971 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          inherit profile;
          inherit host;
        };
        modules = [./profiles/vabyz971];
      };
    };
  };
}
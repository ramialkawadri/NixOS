{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      solaar,
      ...
    }:
    let
      mkSystem =
        {
          hostName,
          username,
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit username;
          };
          modules = [
            # Adds pkgs.stable
            {
              nixpkgs.overlays = [
                (final: _: {
                  stable = import inputs.nixpkgs-stable {
                    inherit (final.stdenv.hostPlatform) system;
                    inherit (final) config;
                  };
                })
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                username = username;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home
                  ./hosts/${hostName}/home
                ];
              };
            }

            ./hosts/common
            ./hosts/${hostName}
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        home-pc = mkSystem {
          hostName = "home-pc";
          username = "ramikw";
          extraModules = [ solaar.nixosModules.default ];
        };
      };
    };
}

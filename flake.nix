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

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, solaar, sddm-sugar-candy-nix, ... }: {
    nixosConfigurations = {
      ramikw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          sddm-sugar-candy-nix.nixosModules.default
          solaar.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ramikw = import ./home.nix;
          }
          ./configuration.nix

          {
            nixpkgs = {
              overlays = [
                sddm-sugar-candy-nix.overlays.default
                (final: _: {
                   stable = import nixpkgs {
                     inherit (final.stdenv.hostPlatform) system;
                     inherit (final) config;
                   };
                 })
              ];
            };
          }
        ];
      };
    };
  };
}

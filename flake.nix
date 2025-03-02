{
  description = "Configuration for host zero";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, home-manager, nixos-cosmic
    , stylix, chaotic, ghostty, zen-browser, rose-pine-hyprcursor, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake = {
        # Code formatter (nixpkgs-fmt)
        formatter.x86_64-linux =
          nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
        # Export custom packages
        # packages.x86_64-linux = { };
        nixosConfigurations = {
          zero = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              # Global
              ./modules/nixos/common/system-options.nix
              ./modules/nixos/common/system-packages.nix
              ./modules/nixos/common/cosmic-cachix.nix
              # Host-specific modules
              ./modules/nixos/zero/hardware-configuration.nix
              ./modules/nixos/zero/boot.nix
              ./modules/nixos/zero/configuration.nix
              # External module inputs
              home-manager.nixosModules.home-manager
              stylix.nixosModules.stylix
              chaotic.nixosModules.default
              nixos-cosmic.nixosModules.default
              # Home Manager module for user "geri"
              ./modules/home/geri.nix
            ];
          };
        };

        # Home Manager configurations for users (allows standalone HM use)
        homeConfigurations = {
          geri = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; };
            modules = [ ./modules/home/geri.nix ];
          };
        };
      };
    };
}

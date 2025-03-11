{
  description = "Configuration for zero";
  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ghostty.url = "github:ghostty-org/ghostty";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprpanel.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , chaotic
    , nixos-cosmic
    , home-manager
    , stylix
    , ghostty
    , zen-browser
    , rose-pine-hyprcursor
    , hyprpanel
    , impermanence
    , ...
    }@inputs: {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        zero = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.overlays = [ hyprpanel.overlay ]; }
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            ./modules/system/zero/options.nix
            ./modules/system/zero/packages.nix
            ./modules/system/zero/host.nix
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            chaotic.nixosModules.default
            nixos-cosmic.nixosModules.default
            {
              home-manager = {
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./modules/home/geri/imports.nix
                ];
              };
            }
          ];
        };
      };
    };
}

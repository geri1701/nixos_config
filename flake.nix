{
  description = "Configuration for zero and one";
  inputs = {
    home-manager = { 
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    stylix.url = "github:danth/stylix/2221c7d61b2e10b17df6c6795b4678fb59a0a92a";
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    , ...
    }@inputs: {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        zero = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
          {
              nix.settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            };
          }
            ./zero-boot.nix
            ./system-options.nix
            ./zero-system-options.nix
            ./system-packages.nix
            ./host-zero.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            chaotic.nixosModules.default
            nixos-cosmic.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./hm-imports.nix
                  ./zero-values.nix
                ];
              };
            }
          ];
        };
        one = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            ./one-boot.nix
            ./system-options.nix
            ./one-system-options.nix
            ./system-packages.nix
            ./host-one.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            chaotic.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./hm-imports.nix
                  ./one-values.nix
                ];
              };
            }
          ];
        };
      };
    };
}

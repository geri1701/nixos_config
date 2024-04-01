{
  description = "Configuration for zero and one";
  inputs = {
    eza.inputs.nixpkgs.follows = "nixpkgs";
    eza.url = "http://rime.cx/v1/github/eza-community/eza.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    joshuto.url = "github:kamiyaa/joshuto";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    stylix.url = "github:danth/stylix";
    helix.url = "github:helix-editor/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    ironbar = {
      url = "github:JakeStanger/ironbar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self
    , nixpkgs
    , chaotic
    , home-manager
    , stylix
    , joshuto
    , ...
    }@inputs: {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      nixosConfigurations = {
        zero = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            ./zero-boot.nix
            ./system-options.nix
            ./zero-system-options.nix
            ./system-packages.nix
            ./host-zero.nix
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
                  ./zero-values.nix
                ];
              };
              nixpkgs.overlays = [ joshuto.overlays.default ];
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
              nixpkgs.overlays = [ joshuto.overlays.default ];
            }
          ];
        };
      };
    };
}

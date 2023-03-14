{
  description = "NixOs configuration for zero";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    sops-nix.url = "github:Mic92/sops-nix";
  };
  outputs = { self, nixpkgs, hyprland, home-manager, sops-nix, ... }@inputs: {
    nixosConfigurations = {
      nix.nixPath = [ "nixpkgs=/home/geri/nixos" ];
      zero = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./system-packages.nix
          home-manager.nixosModules.home-manager
          { programs.hyprland.enable = true; }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.geri.imports = [
                ./home.nix
                sops-nix.homeManagerModules.sops
                hyprland.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
  };
}

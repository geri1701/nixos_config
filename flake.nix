{
  description = "NixOs configuration for zero";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url =
      "github:hyprwm/Hyprland/37ced6aca4ad8f18f8e205e3cdb6de9c8964d4b6";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:danth/stylix";
  };
  outputs =
    { self, nixpkgs, hyprland, home-manager, sops-nix, stylix, ... }@inputs: {
      nixosConfigurations = {
        nix.nixPath = [ "nixpkgs=/home/geri/nixos" ];
        zero = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./zero-boot.nix
            ./system-options.nix
            ./system-packages.nix
            ./host-zero.nix
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {
              home-manager = {
                useGlobalPkgs = true;
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./config/aerc.nix
                  ./config/firefox.nix
                  ./config/foot.nix
                  ./config/git.nix
                  ./config/helix.nix
                  ./config/hyprland.nix
                  ./config/vscode.nix
                  ./config/waybar.nix
                  ./config/zathura.nix
                  ./config/zellij.nix
                  ./config/zsh.nix
                  ./user-options.nix
                  ./user-packages.nix
                  ./sops.nix
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

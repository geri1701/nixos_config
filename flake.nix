{
  description = "NixOs configuration";
  inputs = {
    eza.inputs.nixpkgs.follows = "nixpkgs";
    eza.url = "http://rime.cx/v1/github/eza-community/eza.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "http://rime.cx/v1/github/hyprwm/Hyprland.tar.gz";
    joshuto.url = "github:kamiyaa/joshuto";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
  };
  outputs =
    { self
    , nixpkgs
    , hyprland
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
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./config/zero-firefox.nix
                  ./config/foot.nix
                  ./config/git.nix
                  ./config/helix.nix
                  ./config/hyprland.nix
                  ./config/hyprland_monitor_zero.nix
                  ./config/vscode.nix
                  ./config/waybar.nix
                  ./config/zathura.nix
                  ./config/zellij.nix
                  ./config/zsh.nix
                  ./user-options.nix
                  ./user-packages.nix
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
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./config/one-firefox.nix
                  ./config/foot.nix
                  ./config/git.nix
                  ./config/helix.nix
                  ./config/hyprland.nix
                  ./config/hyprland_monitor_one.nix
                  ./config/vscode.nix
                  ./config/waybar.nix
                  ./config/zathura.nix
                  ./config/zellij.nix
                  ./config/zsh.nix
                  ./user-options.nix
                  ./user-packages.nix
                ];
              };
              nixpkgs.overlays = [ joshuto.overlays.default ];
            }
          ];
        };
      };
    };
}

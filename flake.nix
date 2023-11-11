{
  description = "NixOs configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    tuxedo-rs.url = "github:AaronErhardt/tuxedo-rs";
    realify.url = "github:geri1701/realify";
    gen-session-name.url = "github:geri1701/gen-session-name";
    helix.url = "github:helix-editor/helix/23.10";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    eza.url = "github:eza-community/eza";
    eza.inputs.nixpkgs.follows = "nixpkgs";
    joshuto.url = "github:kamiyaa/joshuto";
  };
  outputs =
    { self
    , nixpkgs
    , hyprland
    , home-manager
    , stylix
    , tuxedo-rs
    , joshuto
    , ...
    }@inputs: {
      nixosConfigurations = {
        nix.nixPath = [ "nixpkgs=/home/geri/nixos" ];
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
                  ./config/aerc.nix
                  ./config/zero-firefox.nix
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
            tuxedo-rs.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.geri.imports = [
                  ./config/aerc.nix
                  ./config/one-firefox.nix
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
                ];
              };
              nixpkgs.overlays = [ joshuto.overlays.default ];
            }
          ];
        };
      };
    };
}

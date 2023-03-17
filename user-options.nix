{ pkgs, ... }:
let
  waybar_exp = (pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  }));
in {
  programs = {
    waybar = {
      enable = true;
      package = waybar_exp;
    };
  };
}

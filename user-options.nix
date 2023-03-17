{ pkgs, ... }:
let
  waybar_exp = (pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  }));
in {
  waybar = {
    enable = true;
    package = waybar_exp;
  };
}

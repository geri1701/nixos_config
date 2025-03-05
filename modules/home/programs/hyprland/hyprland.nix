{ config, ... }: let
  hyprland-config = "${config.home.homeDirectory}/nixos/modules/home/programs/hyprland/hyprland-config";
  in {
  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink hyprland-config;
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprpanel.enable = true;
  programs.hyprpanel.overlay.enable = true;
 }


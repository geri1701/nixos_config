{ config, lib, ... }: let
  hyprland-config = "${config.home.homeDirectory}/nixos/modules/home/programs/hyprland/hyprland-config";
  hyprpanel-config = "${config.home.homeDirectory}/nixos/modules/home/programs/hyprland/hyprpanel-config";
  in {
  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink hyprland-config;
  xdg.configFile."hyprpanel/config.json".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink hyprpanel-config);
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
  };
 }


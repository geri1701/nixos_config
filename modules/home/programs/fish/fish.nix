{ config, ... }: let
fish-config = "${config.home.homeDirectory}/nixos/modules/home/programs/fish/fish-config";
in {
  xdg.configFile."fish/config.fish".source = config.lib.file.mkOutOfStoreSymlink fish-config;
}

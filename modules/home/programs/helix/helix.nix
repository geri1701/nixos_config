{ config, lib, ... }: let
  helix-config = "${config.home.homeDirectory}/nixos/modules/home/programs/helix/helix-config";
  in {
  xdg.configFile."helix/config.toml".source = lib.mkForce (config.lib.file.mkOutOfStoreSymlink helix-config);
  programs.helix = {
    enable = true;
  };
}

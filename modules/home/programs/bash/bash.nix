{ config, ... }:
let
  bashrc = "${config.home.homeDirectory}/nixos/modules/home/programs/bash/bashrc";
  bashProfile = "${config.home.homeDirectory}/nixos/modules/home/programs/bash/bash-profile";
in {
  home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink bashrc;
  home.file.".bash_profile".source = config.lib.file.mkOutOfStoreSymlink bashProfile;
}

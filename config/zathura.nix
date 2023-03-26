{ pkgs, lib, ... }: {
  programs.zathura = {
    enable = true;
    options = {
      recolor-darkcolor = lib.mkDefault "#93a1a1";
      recolor-lightcolor = lib.mkDefault "#002b36";
      recolor = lib.mkDefault "true";
      recolor-reverse-video = "true";
    };
  };
}

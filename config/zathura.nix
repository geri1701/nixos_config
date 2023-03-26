{ pkgs, ... }: {
  programs.zathura = {
    enable = true;
    options = {
      recolor-darkcolor = "#93a1a1";
      recolor-lightcolor = "#002b36";
      recolor = "true";
      recolor-reverse-video = "true";
    };
  };
}

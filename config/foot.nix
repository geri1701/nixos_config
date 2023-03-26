{ pkgs, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "Fantasque Sans Mono:size=10"; };
      mouse = { hide-when-typing = "yes"; };
      colors = { alpha = 0.8; };
    };
  };
}

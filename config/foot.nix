{ lib, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "Fantasque Sans Mono:size=10"; };
      mouse = { hide-when-typing = "yes"; };
      colors = { alpha = lib.mkForce 0.8; };
    };
  };
}

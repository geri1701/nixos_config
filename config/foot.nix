{ lib, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "iosevka:size=10"; };
      colors = { alpha = lib.mkForce 0.8; };
    };
  };
}

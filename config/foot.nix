{ lib, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = { font = "CommitMono:size=10"; };
      colors = { alpha = lib.mkForce 0.8; };
    };
  };
}

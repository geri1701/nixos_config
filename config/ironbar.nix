{inputs, ...}: {
        imports = [ inputs.ironbar.homeManagerModules.default ];
  programs.ironbar = {
    enable = true;
    systemd = true;
    config = {
      position = "top";
      anchor_to_edges = true;
      start = [
       { type = "workspaces"; }
      ];
      end = [
        { type = "tray"; }
        { type = "clock"; }
      ];
    };
  };
}

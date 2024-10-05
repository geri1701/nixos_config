{lib, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "nightfox";
      editor = {
        line-number = "relative";
        mouse = false;
        auto-completion = true;
        auto-info = true;
        true-color = true;
        file-picker.hidden = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        cursorline = true;
        lsp.display-messages = true;
        indent-guides.render = true;
        indent-guides.character = "╎";
        rulers = [ 120 ];
        soft-wrap.enable = true;
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-name" ];
          right = [
            "version-control"
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "|";
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        lsp.display-inlay-hints = true;
      };
      keys.normal = {
        A-x = "extend_to_line_bounds";
        X = [ "extend_line_up" "extend_to_line_bounds" ];
      };
      keys.select = {
        A-x = "extend_to_line_bounds";
        X = [ "extend_line_up" "extend_to_line_bounds" ];
      };
    };
  };
}

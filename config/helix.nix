{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "noctis";
      editor = {
        line-number = "relative";
        mouse = false;
        auto-completion = true;
        auto-info = true;
        true-color = true;
        file-picker.hidden = false;
        cursor-shape.insert = "bar";
        cursor-shape.normal = "block";
        cursor-shape.select = "underline";
        lsp.display-messages = true;
        indent-guides.render = true;
        indent-guides.character = "╎";
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
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        lsp.display-inlay-hints = true;
      };
    };
    languages = {
      awk = {
        auto-format = true;
        formatter.command = "awk";
        formatter.args = [ "-f-" "-o-" ];
      };
      bash = {
        file-types = [ "bats" "sh" ];
        comment-token = "#";
      };
      nix = {
        auto-format = true;
        formatter.command = "nixpkgs-fmt";
      };
    };
  };
}

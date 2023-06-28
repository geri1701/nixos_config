{
  programs.helix = {
    enable = true;
    settings = {
      theme = "solarized_dark";
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
    #   languages.language = [
    #     {
    #       name = "awk";
    #       auto-format = true;
    #       formatter.command = "awk";
    #       formatter.args = [ "-f-" "-o-" ];
    #     }
    #     {
    #       name = "bash";
    #       file-types = [ "bats" "sh" ];
    #       comment-token = "#";
    #     }
    #     {
    #       name = "nix";
    #       formatter = { command = "nixpkgs-fmt"; };
    #       auto-format = true;
    #     }
    #     {
    #       name = "unison";
    #       scope = "source.unison";
    #       injection-regex = "unison";
    #       file-types = [ "u" ];
    #       shebangs = [ ];
    #       roots = [ ];
    #       auto-format = false;
    #       comment-token = "--";
    #       indent = {
    #         tab-width = 4;
    #         unit = "    ";
    #       };
    #       language-server = { command = "ncat"; args = [ "localhost" "5757" ]; };
    #     }
    #   ];
  };
}

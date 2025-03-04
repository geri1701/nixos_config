{
  programs.git = {
    enable = true;
    userName = "geri1701";
    userEmail = "geri@sdf.org";
    signing.signByDefault = true;
    signing.key = null;
    delta = {
      enable = true;
      options = {
        commit-decoration-style = "bold box ul";
        dark = "true";
        file-decoration-style = "none";
        file-style = "omit";
        hunk-header-decoration-style = "#022b45 box ul";
        hunk-header-file-style = "#999999";
        hunk-header-line-number-style = "bold #003300";
        hunk-header-style = "file line-number syntax";
        line-numbers = "true";
        line-numbers-left-style = "#022b45";
        line-numbers-minus-style = "#80002a";
        line-numbers-plus-style = "#003300";
        line-numbers-right-style = "#022b45";
        line-numbers-zero-style = "#999999";
        minus-emph-style = "normal #80002a";
        minus-style = "normal #330011";
        plus-emph-style = "syntax #003300";
        plus-style = "syntax #001a00";
        syntax-theme = "Nord";
      };
    };
  };
}

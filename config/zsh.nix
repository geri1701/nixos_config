{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    initExtraBeforeCompInit = ''
      fpath=($HOME/.zsh/ $fpath)
      source $HOME/.zsh/_zellij
    '';
    initExtraFirst = ''
      pfetch
    '';
    sessionVariables = {
      EDITOR = "hx";
      TERM = "foot";
      DISABLE_AUTO_TITLE = "false";
      ENABLE_CORRECTION = "false";
      HIST_STAMPS = "%y-%m-%d";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "alias-finder" "colored-man-pages" "git" "history" "rust" ];
    };
    loginExtra = ''
      eval "$(zellij setup --generate-auto-start zsh)"
    '';
    profileExtra = ''
      if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
        Hyprland
      fi
    '';
    shellAliases = {
      ls = "exa --icons";
      l = "exa -lbF --git --icons";
      ll = "exa -lbGF --git --icons";
      llm = "exa -lbGd --git --sort=modified --icons";
      la = "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
      lx =
        "exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons";
      lS = "exa -1 --icons";
      lt = "exa --tree --level=2 --icons";
      zellij = ''zellij -s "$(gen-session-name ~/data.txt)"'';
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      size = 600;
      save = 600;
    };
  };
}


{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
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
      ls = "eza --icons";
      l = "eza -lbF --git --icons";
      ll = "eza -lbGF --git --icons";
      llm = "eza -lbGd --git --sort=modified --icons";
      la = "eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
      lx =
        "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons";
      lS = "eza -1 --icons";
      lt = "eza --tree --level=2 --icons";
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


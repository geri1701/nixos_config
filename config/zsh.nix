{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    initExtraBeforeCompInit = ''
      fpath=($HOME/.zsh/ $fpath)
      # source $HOME/.zsh/_zellij
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
      la = "eza -lbhHigUmuSa --time-style=long-iso --git --icons --color-scale all";
      lx =
        "eza -lbhHigUmuSa@ --time-style=long-iso --git --icons --color-scale all";
      lS = "eza -1 --icons";
      lt = "eza --tree --level=2 --icons";
      zellij = ''zellij -s "$(gen-session-name ~/data.txt)"'';
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      size = 1200;
      save = 1200;
    };
    initExtra = ''
                  id-filter-address() {
                  local n=$#
                  local select_string=".[] | select(.from.addr | "
                  for ((i = 1; i <= n; i++)); do
                      select_string+="contains(\"''\${(P)''\${i}}\")"
                      if ((i < n)); then
                          select_string+=", "
                      fi
                  done
                  select_string+=") | .id"
                  local himalaya_command="himalaya envelope list -o json | jq -r '$select_string' | xargs"
                  eval "$himalaya_command"
                  }
                  id-filter-name() {
                  local n=$#
                  local select_string=".[] | select(.from.name | "
                  for ((i = 1; i <= n; i++)); do
                      select_string+="contains(\"''\${(P)''\${i}}\")"
                      if ((i < n)); then
                          select_string+=", "
                      fi
                  done
                  select_string+=") | .id"
                  local himalaya_command="himalaya envelope list -o json | jq -r '$select_string' 2>/dev/null| xargs"
                  eval "$himalaya_command"
                  }
                  command_not_found_handler() {
                  local cmd="$1"
                  shift
                  echo "Command '$cmd' not found; attempting execution with nix run..."
                  nix run nixpkgs#"$cmd" "$@"
                 } 
          '';
      };
}







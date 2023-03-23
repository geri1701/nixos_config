{ pkgs, config, ... }:
let
  waybar_exp = (pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    postPatch = ''
      substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch workspace \" + name_; system(command.c_str());"
    '';
  }));
in {
  gtk = { enable = true; };
  home = {
    stateVersion = "22.11";
    username = "geri";
    homeDirectory = "/home/geri";
    sessionVariables = {
      EDITOR = "hx";
      TERM = "wezterm";
      QT_STYLE_OVERRIDE = "kvantum";
      GTK_USE_PORTAL = 1;
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
  programs = {
    aerc = {
      enable = true;
      extraConfig = {
        general = { unsafe-accounts-conf = true; };
        ui = {
          styleset-name = "styleset";
          timestamp-format = "02 Jan 06 15:04:05";
        };
        filters = {
          "text/plain" = "cat";
          "text/html" = "w3m -I %{charset} -T text/html -cols 125";
        };
      };
      extraAccounts = {
        gmx = {
          source = "imaps://gschwa%40gmx.net@imap.gmx.net:993";
          outgoing = "smtp+plain://gschwa%40gmx.net@mail.gmx.net:587";
          default = "INBOX";
          smtp-starttls = "yes";
          source-cred-cmd = "cat /run/user/1000/secrets/gmx";
          outgoing-cred-cmd = "cat /run/user/1000/secrets/gmx";
          from = "Gerhard <gschwa@gmx.net>";
          copy-to = "Sent";
        };
        sdf = {
          source = "imaps://geri@mx.sdf.org:993";
          outgoing = "smtp+plain://geri@mx.sdf.org:587";
          default = "INBOX";
          smtp-starttls = "yes";
          source-cred-cmd = "cat /run/user/1000/secrets/sdf";
          outgoing-cred-cmd = "cat /run/user/1000/secrets/sdf";
          from = "Gerhard <geri@sdf.org>";
          copy-to = "Sent";
        };
      };
    };
    foot = {
      enable = true;
      settings = {
        main = { font = "Fantasque Sans Mono:size=10"; };
        mouse = { hide-when-typing = "yes"; };
        colors = { alpha = 0.8; };
      };
    };

    home-manager.enable = true;
    helix = {
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
          statusline = {
            left = [ "mode" "spinner" ];
            center = [ "file-name" ];
            right = [
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
        };
      };
      languages = [
        {
          name = "awk";
          auto-format = true;
          formatter.command = "awk";
          formatter.args = [ "-f-" "-o-" ];
        }
        {
          name = "bash";
          file-types = [ "bats" "sh" ];
          comment-token = "#";
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
        }
      ];
    };
    git = {
      enable = true;
      userName = "geri";
      userEmail = "geri@sdf.org";
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
    skim.enable = true;
    bottom.enable = true;
    zellij = {
      enable = true;
      # todo: add settings as soon https://github.com/nix-community/home-manager/issues/3364 is closed
      # and kdl is possible
    };
    firefox = {
      enable = true;
      profiles.geri.settings = {
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.all" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "layout.css.devPixelsPerPx" = "0.65";
        "extensions.webextensions.tabhide.enabled" = true;
        "browser.startup.homepage" = "localhost:9090/bookmarks";
        "browser.sessionstore.resume_from_crash" = false;
      };
    };
    vscode.enable = true;
    zathura = {
      enable = true;
      options = {
        recolor-darkcolor = "#93a1a1";
        recolor-lightcolor = "#002b36";
        recolor = "true";
        recolor-reverse-video = "true";
      };
    };
    zoxide.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableAutosuggestions = true;
      initExtra = ''
        pfetch
      '';
      sessionVariables = {
        EDITOR = "hx";
        TERM = "wezterm";
        DISABLE_AUTO_TITLE = "false";
        ENABLE_CORRECTION = "true";
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
        la =
          "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
        lx =
          "exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons";
        lS = "exa -1 --icons";
        lt = "exa --tree --level=2 --icons";
      };
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        size = 600;
        save = 600;
      };
    };
    starship.enable = true;
    waybar = {
      enable = true;
      package = waybar_exp;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  services = {
    gpg-agent = { enable = true; };
    network-manager-applet.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "~/music";
      extraConfig = ''
        audio_output {
            type "pulse"
            name "My Pulse Output"
        }
      '';
    };
    dunst = { enable = true; };
    pasystray.enable = true;
    gnome-keyring.enable = true;
  };
  stylix.targets.helix.enable = false;
  stylix.targets.vscode.enable = false;
  stylix.fonts.sizes.terminal = 10;
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  xdg = { enable = true; };
}

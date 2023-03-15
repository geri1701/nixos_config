{ pkgs, ... }:
let
  print_email_ids = { };
  print_workspace_string = { };
in {
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  xdg.enable = true;
  home = {
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
    himalaya = {
      enable = true;
      settings = {
        gmx = {
          default = true;
          email = "gschwa@gmx.net";
          backend = "imap";
          imap-host = "imap.gmx.net";
          imap-port = 993;
          imap-login = "gschwa@gmx.net";
          imap-passwd-cmd = "cat /run/user/1000/secrets/gmx";
          sender = "smtp";
          smtp-host = "mail.gmx.net";
          smtp-port = 587;
          smtp-login = "gschwa@gmx.net";
          smtp-passwd-cmd = "cat /run/user/1000/secrets/gmx";
          email-listing-page-size = 50;
          downloads-dir = "/home/geri/mail_att";
        };
        sdf = {
          email = "geri@sdf.org";
          backend = "imap";
          imap-host = "mx.sdf.org";
          imap-port = 993;
          imap-login = "geri";
          imap-passwd-cmd = "cat /run/user/1000/secrets/sdf";
          sender = "smtp";
          smtp-host = "mx.sdf.org";
          smtp-port = 587;
          smtp-starttls = true;
          smtp-login = "geri";
          smtp-passwd-cmd = "cat /run/user/1000/secrets/sdf";
          email-listening-page-size = 50;
          downloads-dir = "/home/geri/mail_att";
        };
      };
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
      };
    };
    vscode.enable = true;
    waybar.enable = true;
    wezterm = {
      enable = true;
      extraConfig = ''
        local wezterm = require 'wezterm';
        return {
          -- Fonts
          font     	= wezterm.font("FantasqueSansMono"),
          font_size	= 10.0, -- [12.0]
          text_blink_rate = 0,  
          -- Colors
          color_scheme = "Silk Dark (base16)",
          -- Appearance
          window_background_opacity   	= 0.9  	,
          enable_tab_bar              	= false	,
          hide_tab_bar_if_only_one_tab	= false	,
          window_close_confirmation = 'NeverPrompt',
          skip_close_confirmation_for_processes_named = {
            'bash',
            'sh',
            'zsh',
            'fish',
            'tmux',
            'nu',
            'cmd.exe',
            'pwsh.exe',
            'powershell.exe',
          },
          scrollback_lines = 6000,
          	audible_bell = 'SystemBeep',
        	visual_bell = {
        		fade_in_duration_ms = 20,
        		fade_out_duration_ms = 200,
        		fade_in_function = 'Linear',
        		fade_out_function = 'EaseOut',
        	},
          keys = {
            {
              key = 'C',
              mods = 'CTRL',
              action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
            },
          },
        } 
      '';
    };
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
  };
  services = {
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
    dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#586e75";
          font = "Droid Sans 9";
        };

        urgency_normal = {
          background = "#073642";
          foreground = "#93a1a1";
          timeout = 10;
        };
      };
    };
    pasystray.enable = true;
    gnome-keyring.enable = true;
  };
  gtk = {
    enable = true;
    font.name = "Victor Mono SemiBold 12";
    theme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
    iconTheme = {
      name = "material-black";
      package = pkgs.tela-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

}

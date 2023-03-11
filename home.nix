{ self, input, config, pkgs, lib, ... }:
let
  print_email_ids =
    pkgs.callPackage /home/geri/projects/rust/print_email_ids { };
  print_workspace_string =
    pkgs.callPackage /home/geri/projects/rust/print_workspace_string { };
in {
  # imports = [ <sops-nix/modules/home-manager/sops.nix> ];
  # imports = [ sops-nix.homeManagerModules.sops ];
  # inputs = sops-nix.homeManagerModules.sops;
  sops = {
    age.keyFile = "/home/geri/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets/zero.yaml;
    secrets = {
      amazon = { };
      discord = { };
      github = { };
      gmx = { };
      google = { };
      humble = { };
      iee = { };
      manning = { };
      mechanicalkeyboardsdotcom = { };
      no_starch_press = { };
      packt = { };
      paypal = { };
      pine64_forum = { };
      pine64_support = { };
      planery = { };
      scratch = { };
      sdf = { };
      steam = { };
      thalia = { };
      typingclub = { };
      wienenergie = { };
    };
  };
  systemd.user.services.mbsync.Unit.After = [ "sops-nix.service" ];
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1
      exec-once=dunst
      exec-once=waybar 
      exec-once=hyprpaper
      exec-once=steam -no-browser

      input {
          kb_file=
          kb_layout= us
          kb_variant= altgr-intl
          kb_model=
          kb_options= caps:escape
          kb_rules=

          follow_mouse=1

          touchpad {
              natural_scroll=no
          }

          sensitivity=0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # main_mod=SUPER

          gaps_in=6
          gaps_out=15
          border_size=0
          col.active_border= 0x44FF7F00
          col.inactive_border=0x66333333

          apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)

        #  damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer
      }

      decoration {
          rounding=15
          blur=1
          blur_size=3 # minimum 1
          blur_passes=1 # minimum 1
          blur_new_optimizations=1
      }

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animations {
          enabled=1
          #animation=windows,1,2,default
          animation=border,1,3,default
          animation=fade,1,3,default
          animation=workspaces,1,6,default
          animation=windows,1,8,myBezier, popin 80%

      }

      dwindle {
          pseudotile=0 # enable pseudotiling on dwindle
      }

      gestures {
          workspace_swipe=no
      }

      # example window rules
      # for windows named/classed as abc and xyz
      #windowrule=move 69 420,abc
      #windowrule=size 420 69,abc
      #windowrule=tile,xyz
      #windowrule=float,abc
      #windowrule=pseudo,abc
      #windowrule=monitor 0,xyz
      #
      #
      #
      # for floating chrome save file dialogs 
      windowrule=float,^(xdg-desktop-portal-gnome)$
      windowrule=float,^(Rofi)$
      windowrule=float,^(jetbrains-studio)$
      # some nice mouse binds
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      # example binds
      bind=SUPER,Q,exec,wezterm
      bind=SUPER,RETURN,exec,wezterm
      bind=SUPER,C,killactive,
      bind=SUPER,M,exec,~/.config/rofi/bin/leave.sh
      bind=SUPER,P,exec,sirula
      bind=ALT,P,exec,~/.config/hypr/bin/clip-color.sh
      bind=SUPER,E,exec,nemo
      bind=SUPER,F,togglefloating,
      bind=ALT,SPACE,exec,~/.config/rofi/bin/app-launcher.sh
      bind=SUPER,V,pseudo

      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d

      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10

      bind=ALT,1,movetoworkspace,1
      bind=ALT,2,movetoworkspace,2
      bind=ALT,3,movetoworkspace,3
      bind=ALT,4,movetoworkspace,4
      bind=ALT,5,movetoworkspace,5
      bind=ALT,6,movetoworkspace,6
      bind=ALT,7,movetoworkspace,7
      bind=ALT,8,movetoworkspace,8
      bind=ALT,9,movetoworkspace,9
      bind=ALT,0,movetoworkspace,10

      bind=SUPER,mouse_down,workspace,e+1
      bind=SUPER,mouse_up,workspace,e-1
      bind = SUPER,Tab,cyclenext,          # change focus to another window
      bind = SUPER,Tab,bringactivetotop,   # bring it to the top

    '';
  };
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
    packages = with pkgs; [
      armcord
      calcure
      cht-sh
      chafa
      cinnamon.nemo-with-extensions
      ddgr
      exercism
      fsuae
      fsuae-launcher
      glow
      grim
      hyprpaper
      inkscape-with-extensions
      joshuto
      lesspass-cli
      libsForQt5.qtstyleplugin-kvantum
      luajitPackages.vicious
      lxqt.lxqt-qtplugin
      mpc-cli
      mpdevil
      mpv
      nil
      obsidian
      oculante
      p7zip
      print_email_ids
      print_workspace_string
      sirula
      slurp
      thunderbird # maybe enable?
      tixati
      tldr
      translate-shell
      typespeed
      unzip
      vscode-extensions.vadimcn.vscode-lldb
      wine
      winetricks
      wl-clipboard
      wofi
      xorg.xkill
      xsel
      yt-dlp
      ytfzf
      killall
      zsh-autosuggestions
      zsh-you-should-use
    ];
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
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
          whitespace-error-style = "22 reverse";
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
    dunst.enable = true;
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

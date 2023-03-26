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
      TERM = "foot";
      QT_STYLE_OVERRIDE = "kvantum";
      GTK_USE_PORTAL = 1;
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
  programs = {
    home-manager.enable = true;
    skim.enable = true;
    bottom.enable = true;
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
    vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages
        (ps: with ps; [ rustup zlib openssl.dev pkg-config ]);
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
        TERM = "foot";
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
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passtrough = false;
          height = 0;
          modules-left = [ "wlr/workspaces" "network" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "pulseaudio" "custom/weather" "tray" "clock" ];
          "wlr/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            sort-by-number = true;
          };
          network = {
            interface = "eno1*";
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };
          "hyprland/window" = {
            format = "{}";
            seperate-outputs = true;
          };
          "pulseaudio" = {
            scroll-step = 1;
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = "{volume}% {icon} {format_source}";
            format-muted = "{volume}% {icon} {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = { "default" = [ "" "" "" ]; };
            on-click = "pulsemixer --toggle-mute";
          };
          "custom/weather" = {
            exec = "curl 'https://wttr.in/?format=1'";
            interval = 3600;
          };
          "tray" = {
            icon-size = 21;
            spacing = 5;
          };
          "clock" = {
            format = "{:%d.%m.%Y %H:%M:%S}";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
            interval = 1;
          };
        };
      };
      style = ''
                * {
            border: none;
            border-radius: 0;
            font-family: Cartograph CF Nerd Font, monospace;
            font-weight: bold;
            font-size: 14px;
            min-height: 0;
        }

        window#waybar {
            background: rgba(21, 18, 27, 0);
            color: #cdd6f4;
        }

        tooltip {
            background: #002b36;
            border-radius: 10px;
            border-width: 2px;
            border-style: solid;
            border-color: #11111b;
        }

        #workspaces button {
            padding: 5px;
            color: #333333;
            margin-right: 5px;
            background: #002b36;    
        }

        #workspaces button.active {
            color: #a6adc8;
        }

        #workspaces button.focused {
            color: #a6adc8;
            background: #002b36;
            border-radius: 10px;
        }

        #workspaces button.urgent {
            color: #11111b;
            background: #002b36;
            border-radius: 10px;
        }

        #workspaces button:hover {
            background: #002b36; /**/
            color: #002b36;
            border-radius: 10px;
        }

        #custom-weather,
        #window,
        #clock,
        #battery,
        #pulseaudio,
        #network,
        #workspaces,
        #tray {
            background: #002b36;
            padding: 0px 10px; 
            margin-top: 3px;
            border: 1px solid #181825;
        }

        #tray {
            border-radius: 10px;
            margin-right: 5px;
        }

        #workspaces {
            background: #002b36;
            border-radius: 10px;
            margin-left: 10px;
            margin-right: 5px;    
            padding-right: 0px;
            padding-left: 5px;
        }

        #custom-language {
            color: #f38ba8;
            border-left: 0px;
            border-right: 0px;
        }

        #window {
            border-radius: 10px;
            margin-left: 60px;
            margin-right: 60px;
        }

        #clock {
            color: #fab387;
            border-radius: 10px;
            margin-left: 5px;
            margin-right: 10px;    
            border-right: 0px;
        }

        #network {
            color: #f9e2af;
            border-left: 0px;
            border-right: 0px;
            border-radius: 10px;    
        }

        #pulseaudio {
            color: #89b4fa;
            border-left: 0px;
            border-right: 0px;
            border-radius: 10px;
            margin-right: 5px;        
        }

        #pulseaudio.microphone {
            color: #cba6f7;
            margin-right: 5px;
            border-radius: 10px;
        }

        #custom-weather {
            border-radius: 0px 10px 10px 0px;
            border-right: 0px;
            margin-left: 0px;
            margin-right: 5px;    
            border-radius: 10px;    
        }
      '';
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

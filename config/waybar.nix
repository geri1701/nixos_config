{ pkgs, ... }: {
  programs.waybar = {
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
}

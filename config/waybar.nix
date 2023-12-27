{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passtrough = false;
        height = 0;
        modules-left = [ "hyprland/workspaces" "network" "battery" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio" "custom/weather" "tray" "clock" ];
        "hyprland/workspaces" = {
          all-outputs = true;
          active-only = false;
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
          persistent_workspaces = {
            "*" = 5;
          };
        };
        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} 󱘖";
          tooltip-format = "{ifname} via {gwaddr} 󱘖";
          format-linked = "{ifname} (No IP) 󰌙";
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
          exec =
            "wthrr -l de | sed -n '5p' | sed -e 's/^[^[:print:]]*//' -e 's/^│s*//' -e 's/s*│s*$//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'| sed 's/.*/_&_/'
";
          interval = 1800;
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
        "battery" = {
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-icons" = [ "" "" "" "" "" ];
          "max-length" = 25;
        };
      };
    };
  };
}

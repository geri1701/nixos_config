{ config, pkgs, lib, inputs, ... }:
let
  print_email_ids = (pkgs.writeShellScriptBin "print_email_ids" ''
    input=$(sed -E 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g')
    output=$(echo "$input" | awk 'NR > 1 {split($0,a," "); if (a[1] ~ /^[0-9]+$/) {printf("%s,",a[1])}}' | sed 's/,$//')
    echo "$output" 
  '');
  oldest = (pkgs.writeShellScriptBin "oldest" ''
      if [ $# -lt 1 ]; then
        echo "Usage: $(basename $0) <input_file> [<name>]"
        exit 1
    fi
    input_file="$1"
    if [ ! -r "$input_file" ]; then
        echo "Error: input file '$input_file' does not exist or is not readable."
        exit 1
    fi
    if [ ! -s "$input_file" ]; then
        echo "Error: input file '$input_file' is empty."
        exit 1
    fi
    if [ $# -eq 2 ]; then
        name="$2"
    if grep -q "^$name$" "$input_file"; then
            sed -i "/^$name\$/d" "$input_file"
        else
            echo "Error: name '$name' not found in input file."
            exit 1
        fi
     echo "$name" >> "$input_file"
    fi
    top_line=$(head -n 1 "$input_file")
    name=$(echo "$top_line")
    echo "$name"
  '');
  toggle_touchpad = (pkgs.writeShellScriptBin "toggle_touchpad" ''
    readonly hyprland_device="uniw0001:00-093a:0255-touchpad"
    readonly status_file="/run/user/1000/touchpad.status"
    enable_touchpad() {
    echo "true" > "$status_file"
    notify-send -u normal "Enabling Touchpad"
    hyprctl keyword "device:$hyprland_device:enabled" true
    }
    disable_touchpad() {
      echo "false" > "$status_file"
      notify-send -u normal "Disabling Touchpad"
      hyprctl keyword "device:$hyprland_device:enabled" false
     }
     if [[ ! -f "$status_file" ]]; then
       enable_touchpad
     else
       case "$(cat "$status_file" 2>/dev/null)" in
         "true")
           disable_touchpad ;;
         "false")
           enable_touchpad ;;
         *)
           enable_touchpad ;;
       esac
     fi
  '');
  real_name = (pkgs.writeShellScriptBin "real_name" ''
    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            --config)
            CONFIG="$2"
            shift
            shift
            ;;
            --name)
            NAME="$2"
            shift
            shift
            ;;
            *)
            echo "Unknown argument: $1"
            exit 1
            ;;
        esac
    done
    VALUE=$(grep "^$NAME\s" "$CONFIG" | cut -f2- -d' ')
    if [[ -n "$VALUE" ]]; then
        echo "$VALUE"
    else
        echo "Error: Your config doesn't contain the key $NAME" >&2
        exit 1
    fi
  '');
in {
  home.packages = with pkgs; [
    calcure
    cht-sh
    ddgr
    discord
    exercism
    fsuae
    fsuae-launcher
    glow
    grim
    libsixel
    inkscape-with-extensions
    itd
    joshuto
    kalker
    libsForQt5.qtstyleplugin-kvantum
    luajitPackages.vicious
    lxqt.lxqt-qtplugin
    mpc-cli
    mpdevil
    mpv
    nm-tray
    nil
    libnotify
    obsidian
    oculante
    oldest
    pcmanfm
    p7zip
    print_email_ids
    real_name
    sirula
    siglo
    slurp
    swaybg
    tldr
    toggle_touchpad
    translate-shell
    typespeed
    unzip
    vscode-extensions.vadimcn.vscode-lldb
    watchmate
    w3m
    wine
    winetricks
    wl-clipboard
    wofi
    xdg-utils
    yt-dlp
    ytfzf
    killall
    zsh-autosuggestions
    zsh-you-should-use
  ];
}


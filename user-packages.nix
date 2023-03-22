{ pkgs, lib, ... }:
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
    inkscape-with-extensions
    joshuto
    kalker
    libsForQt5.qtstyleplugin-kvantum
    luajitPackages.vicious
    lxqt.lxqt-qtplugin
    mpc-cli
    mpdevil
    mpv
    nil
    libnotify
    obsidian
    oculante
    oldest
    pcmanfm
    p7zip
    print_email_ids
    sirula
    slurp
    swaybg
    tldr
    translate-shell
    typespeed
    unzip
    vscode-extensions.vadimcn.vscode-lldb
    w3m
    wine
    winetricks
    wl-clipboard
    wofi
    yt-dlp
    ytfzf
    killall
    zsh-autosuggestions
    zsh-you-should-use
  ];
}


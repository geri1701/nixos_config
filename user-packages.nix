{ pkgs, lib, ... }:
let
  print_email_ids = (pkgs.writeShellScriptBin "print_email_ids" ''
    input=$(sed -E 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g')
    output=$(echo "$input" | awk 'NR > 1 {split($0,a," "); if (a[1] ~ /^[0-9]+$/) {printf("%s,",a[1])}}' | sed 's/,$//')
    echo "$output" 
  '');
in {
  home.packages = with pkgs; [
    calcure
    cht-sh
    chafa
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
    pcmanfm
    p7zip
    print_email_ids
    sirula
    slurp
    swaybg
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
}


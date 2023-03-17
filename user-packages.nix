{ pkgs, ... }:
let print_email_ids = { };
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
    # print_email_ids
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


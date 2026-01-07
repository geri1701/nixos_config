{ pkgs, ... }:
let
      toggle-sink = pkgs.writeShellScriptBin "toggle-sink"  ''
          SINK_A="alsa_output.pci-0000_03_00.1.hdmi-stereo"
          SINK_B="alsa_output.usb-ROCCAT_Elo_7.1_USB-00.analog-stereo"
          CURRENT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')
          if [ "$CURRENT_SINK" = "$SINK_A" ]; then
            pactl set-default-sink "$SINK_B"
          else
            pactl set-default-sink "$SINK_A"
          fi
        '';
     comfyui-drop-caches = pkgs.writeShellScriptBin "comfyui-drop-caches" ''
        set -eu
        ${pkgs.coreutils}/bin/sync
        echo 3 > /proc/sys/vm/drop_caches
      '';
      rotate-wallpaper = pkgs.writeShellScriptBin "rotate-wallpaper" ''
      set -euo pipefail

      WALLROOT="$HOME/Pictures/wallpapers"
      STATE="/var/tmp/hypr-wallpaper-mode.state"
      MODE="$(cat "$STATE" 2>/dev/null || echo light)"
      DIR="$WALLROOT/$MODE"

      IMG="$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)"
      [ -n "$IMG" ] || exit 0

      hyprctl hyprpaper preload "$IMG" >/dev/null
      hyprctl hyprpaper wallpaper ",$IMG" >/dev/null
  '';
      toggle-wallpaper = pkgs.writeShellScriptBin "toggle-wallpaper" ''
        set -euo pipefail

        WALLROOT="$HOME/Pictures/wallpapers"
        STATE="/var/tmp/hypr-wallpaper-mode.state"
        
        CURRENT="$(cat "$STATE" 2>/dev/null || echo light)"
        if [ "$CURRENT" = "light" ]; then
          NEW="dark"
        else
          NEW="light"
        fi
        
        # Mode dauerhaft setzen
        echo "$NEW" > "$STATE"
        
        DIR="$WALLROOT/$NEW"
        IMG="$(find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)"
        [ -n "$IMG" ] || exit 0
        
        hyprctl hyprpaper preload "$IMG" >/dev/null
        hyprctl hyprpaper wallpaper ",$IMG" >/dev/null

       '';
in
{
  home.packages = with pkgs; [
   toggle-sink
   toggle-wallpaper
   rotate-wallpaper
   comfyui-drop-caches
    amdgpu_top
    # aseprite
    ardour
    ashell
    atuin
    bogofilter
    cht-sh
    clipse
    ddgr
    (discord.override {
      withOpenASAR = false;
    })
    (pkgs.writeShellScriptBin "fs-uae-launcher" ''
      export QT_QPA_PLATFORM=xcb
      exec ${pkgs.fsuae-launcher}/bin/fs-uae-launcher "$@"
    '')
    ripgrep
    distrobox
    docker-compose
    etlegacy
    evince
    exercism
    fastfetch
    fsuae
    gh
    gdal
    geeqie
    geogebra
    (gimp-with-plugins.override{
    plugins = with pkgs.gimpPlugins; [
      gmic
      resynthesizer
    ];
  })
    glow
    glicol-cli
    graph-easy
    grim
    grex
    gnupg
    helix-gpt
    hyprshade
    hyprlandPlugins.hyprscrolling
    nwg-panel
    joshuto
    jq
    kalker
    keepassxc
    kbs2
    kibi
    kitty
    kitty-themes
    libnotify
    libsForQt5.qtstyleplugin-kvantum
    libsixel
    lsp-plugins
    luajitPackages.vicious
    marksman
    mangohud
    meson
    mpc
    mpv
    mpvpaper
    nap
    nextcloud-client
    nmap
    nodejs
    nomacs
    nil
    nixpkgs-fmt
    nixpkgs-review
    neovim
    nuclear
    nwg-drawer
    nwg-look
    # oculante
    ouch
    p7zip
    peep
    protonmail-desktop
    proton-pass
    quickshell
    # rx
    scriptisto
    slurp
    sniffnet
    swappy
    swaybg
    steamcmd
    sysmenu
    # sonic-pi
    taskwarrior3
    taskwarrior-tui
    tldr
    translate-shell
    typespeed
    typst
    vice
    w3m
    wayland-protocols
    wayland-utils
    wlroots
    wine
    winetricks
    wl-clipboard
#    wolfram-engine
    wpaperd
    wthrr
    xdg-utils
    xplr
    yazi
    yt-dlp
    # zeal
    zellij
  ];
}

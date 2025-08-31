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
in
{
  home.packages = with pkgs; [
    toggle-sink
    anyrun
    amdgpu_top
    # aseprite
    atuin
    bogofilter
    cht-sh
    clipse
    ddgr
    (discord.override {
      withOpenASAR = false;
    })
    distrobox
    docker-compose
    etlegacy
    evince
    exercism
    fastfetch
    floorp
    gh
    gdal
    geogebra
    # gimp-with-plugins
    glow
    glicol-cli
    graph-easy
    grim
    grex
    gnupg
    gpt4all
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
    # libsForQt5.qtstyleplugin-kvantum
    libsixel
    luajitPackages.vicious
    marksman
    mangohud
    meson
    mpc-cli
    mpv
    mpvpaper
    nap
    nextcloud-client
    nmap
    nodejs
    nil
    nixpkgs-fmt
    nixpkgs-review
    neovim
    nuclear
    nwg-drawer
    nwg-look
    oculante
    ouch
    p7zip
    peep
    protonmail-desktop
    proton-pass
    rx
    scriptisto
    slurp
    sniffnet
    swappy
    swaybg
    swww
    steamcmd
    # sonic-pi
    taskwarrior3
    taskwarrior-tui
    tldr
    translate-shell
    typespeed
    typst
    typst-fmt
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
    zeal
    zellij
    zsh-autosuggestions
    zsh-you-should-use
  ];
}

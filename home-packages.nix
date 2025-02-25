{ pkgs, ... }:
let
  # himalaya = pkgs.himalaya.override { withNotmuchBackend = true; };
  toggle_touchpad = pkgs.writeShellScriptBin "toggle_touchpad" ''
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
  '';
in
{
  home.packages = with pkgs; [
    anyrun
    afew
    amdgpu_top
    # aseprite
    atuin
    bogofilter
    (flameshot.override { enableWlrSupport = true; })
    notmuch-bower
    cht-sh
    claws-mail
    ddgr
    (discord.override {
      withOpenASAR = false;
    })
    distrobox
    docker-compose
    etlegacy
    exercism
    fastfetch
    gh
    github-copilot-cli
    gdal
    geogebra
    gimp
    glow
    glicol-cli
    graph-easy
    grim
    grex
    gnupg
    gpt4all-cuda
    helix-gpt
    himalaya
    hyprshade
    nwg-panel
    joshuto
    jq
    kdePackages.krohnkite
    kalker
    keepassxc
    kbs2
    kibi
    kitty
    kitty-themes
    libnotify
    libsForQt5.qtstyleplugin-kvantum
    libsixel
    luajitPackages.vicious
    marksman
    mangohud
    meson
    mpc-cli
    mpv
    mpvpaper
    nextcloud-client
    nmap
    nodejs
    notmuch
    nil
    nixpkgs-fmt
    nixpkgs-review
    neovim
    nm-tray
    networkmanagerapplet
    nuclear
    nwg-drawer
    nwg-look
    oculante
    ouch
    p7zip
    peep
    plasma-panel-colorizer
    protonmail-desktop
    proton-pass
    rx
    scriptisto
    slurp
    sniffnet
    swappy
    swaybg
    steamcmd
    sonic-pi
    taskwarrior3
    taskwarrior-tui
    thunderbird
    tldr
    toggle_touchpad
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
    wolfram-engine
    wthrr
    xdg-utils
    xplr
    yazi
    yt-dlp
    zeal
    zed-editor_git
    zellij
    zsh-autosuggestions
    zsh-you-should-use
  ];
}

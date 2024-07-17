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
    afew
    amdgpu_top
    alot
    atuin
    bogofilter
    notmuch-bower
    cht-sh
    claws-mail
    ddgr
    (discord.override {
      withOpenASAR = true;
    })
    distrobox
    docker-compose
    dstask
    element
    element-desktop
    etlegacy
    exercism
    geogebra
    gbar
    gimp
    glow
    glicol-cli
    graph-easy
    grim
    grex
    gnupg
    gpt4all
    helix-gpt
    himalaya
    hyprshade
    joshuto
    jq
    kalker
    keepassxc
    kbs2
    kibi
    kitty
    kitty-themes
    kiwix
    libnotify
    libsForQt5.qtstyleplugin-kvantum
    libsixel
    luajitPackages.vicious
    lxqt.lxqt-qtplugin
    marksman
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
    obsidian
    oculante
    ouch
    p7zip
    pcmanfm
    peep
    protonmail-desktop
    protonmail-bridge
    rx
    slurp
    sniffnet
    swappy
    swaybg
    steamcmd
    sonic-pi
    the-way
    thunderbird
    tldr
    toggle_touchpad
    translate-shell
    typespeed
    typst
    typst-fmt
    vscode-extensions.vadimcn.vscode-lldb
    w3m
    wayland-protocols
    wayland-utils
    wlroots
    wine
    winetricks
    wl-clipboard
    wofi
    wthrr
    xdg-utils
    xplr
    yt-dlp
    zeal
    zsh-autosuggestions
    zsh-you-should-use
  ];
}

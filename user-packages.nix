{ pkgs, inputs, ... }:
let
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
in
{
  home.packages = with pkgs; [
    amdgpu_top
    cht-sh
    claws-mail
    ddgr
    discord
    exercism
    gimp
    glow
    graph-easy
    grim
    inputs.realify.defaultPackage.x86_64-linux.out
    inputs.gen-session-name.defaultPackage.x86_64-linux.out
    joshuto
    jq
    kalker
    kbs2
    kibi
    libnotify
    libsForQt5.qtstyleplugin-kvantum
    libsixel
    luajitPackages.vicious
    lxqt.lxqt-qtplugin
    marksman
    mpc-cli
    mpv
    musikcube
    nextcloud-client
    nmap
    nil
    nixpkgs-fmt
    nixpkgs-review
    neovim
    nodejs
    nwg-drawer
    nwg-look
    obsidian
    oculante
    ouch
    p7zip
    pcmanfm
    peep
    rx
    sfwbar
    slurp
    sniffnet
    swappy
    swaybg
    the-way
    tldr
    toggle_touchpad
    translate-shell
    transmission-gtk
    typespeed
    typst
    typst-fmt
    vscode-extensions.vadimcn.vscode-lldb
    w3m
    watchmate
    wine
    winetricks
    wl-clipboard
    wofi
    wthrr
    xdg-utils
    xplr
    yt-dlp
    ytfzf
    zeal
    zsh-autosuggestions
    zsh-you-should-use
  ];
}

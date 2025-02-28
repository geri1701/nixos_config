{  pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    docfd
    ddcutil
    eza
    gamemode
    gparted
    helix
    hyprcursor
    libsForQt5.qtstyleplugin-kvantum
    linux-manual
    lm_sensors
    man-pages
    man-pages-posix
    networkmanager
    obsidian
    openssl
    pfetch
    rust-analyzer
    qmk-udev-rules
    screen
    sshfs
    tmux
    tree
    via
    virt-manager
    vscode
    wget
    zoxide
    # Pakete aus externen Flakes (zugänglich via `inputs` dank specialArgs):
    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}."zen-browser"
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}."rose-pine-hyprcursor"
  ];
}

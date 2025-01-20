{ pkgs, ghostty, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docfd
      eza
      gamemode
      ghostty.packages.x86_64-linux.default
      gparted
      helix
      libsForQt5.qtstyleplugin-kvantum
      linux-manual
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
      wget
      zoxide
    ];
  };
}

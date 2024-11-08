{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docfd
      eza
      gparted
      helix
      libsForQt5.qtstyleplugin-kvantum
      linux-manual
      man-pages
      man-pages-posix
      networkmanager
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

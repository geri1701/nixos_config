{ pkgs, ghostty, zen-browser, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docfd
      ddcutil
      eza
      gamemode
      ghostty.packages.x86_64-linux.default
      gparted
      helix
      hyprcursor
      rose-pine-hyprcursor
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
      zen-browser.packages."${system}".default
      zoxide
    ];
  };
}

{ pkgs,inputs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      uutils-coreutils-noprefix
      hyprpanel
      docfd
      ddcutil
      eza
      fd
      gamemode
      ghostty
      gparted
      helix
      hyprcursor
      rose-pine-hyprcursor
      libsForQt5.qtstyleplugin-kvantum
      # linux-manual
      lm_sensors
      man-pages
      man-pages-posix
      networkmanager
      obsidian
      openssl
      pfetch
      pulseaudio
      rust-analyzer
      qmk-udev-rules
      screen
      sshfs
      tailspin
      tmux
      tree
      via
      virt-manager
      vscode
      wget
      inputs.zen-browser.packages."${system}".default
      zoxide
      fsuae-launcher
      fsuae
    ];
  };
}

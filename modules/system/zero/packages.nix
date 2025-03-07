{ pkgs,inputs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      hyprpanel
      docfd
      ddcutil
      eza
      gamemode
      inputs.ghostty.packages.x86_64-linux.default
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
      inputs.zen-browser.packages."${system}".default
      zoxide
    ];
  };
}

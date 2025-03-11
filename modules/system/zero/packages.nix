{ pkgs,inputs, ... }: {
  environment = {
  #etc = {
   #  "group".source = "/nix/persist/etc/group";
   #  "passwd".source = "/nix/persist/etc/passwd";
    # "shadow".source = "/nix/persist/etc/shadow";
   #};
    systemPackages = with pkgs; [
      uutils-coreutils-noprefix
      hyprpanel
      docfd
      ddcutil
      eza
      fd
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

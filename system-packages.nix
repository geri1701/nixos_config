{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docfd
      eza
      gparted
      helix
      libsForQt5.qtstyleplugin-kvantum
      networkmanager
      openssl
      pfetch
      rust-analyzer
      screen
      sshfs
      tmux
      tree
      virt-manager
      wget
      zoxide
    ];
  };
}

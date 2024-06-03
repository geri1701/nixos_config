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
      sshfs
      tree
      virt-manager
      wget
      zoxide
    ];
  };
}

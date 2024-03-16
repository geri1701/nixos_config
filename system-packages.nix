{ pkgs, eza, ... }: {
  environment = {
    systemPackages = with pkgs; [
      docfd
      eza.packages."${pkgs.system}".default
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

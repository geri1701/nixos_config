{ pkgs, eza, ... }: {
  environment = {
    systemPackages = with pkgs; [
      eza.packages."${pkgs.system}".default
      gparted
      helix
      libsForQt5.qtstyleplugin-kvantum
      networkmanager
      openssl
      pfetch
      pinentry-gnome
      rnix-lsp
      rust-analyzer
      sshfs
      tree
      virt-manager
      wget
      zoxide
    ];
  };
}

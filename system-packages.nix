{ pkgs, helix, eza, ... }: {
  environment = {
    systemPackages = with pkgs; [
      gparted
      libsForQt5.qtstyleplugin-kvantum
      networkmanager
      openssl
      age
      rnix-lsp
      rust-analyzer
      sshfs
      starship
      tree
      virt-manager
      vulkan-tools
      wget
      zoxide
      eza.packages."${pkgs.system}".default
      helix.packages."${pkgs.system}".helix
      pfetch
    ];
  };
}

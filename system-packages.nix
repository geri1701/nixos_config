{ pkgs, helix, eza, ... }: {
  environment = {
    systemPackages = with pkgs; [
      gparted
      libiconv
      libsForQt5.qtstyleplugin-kvantum
      networkmanager
      nixos-option
      nix-prefetch-git
      openssl
      pfetch
      pinentry
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
    ];
  };
}

{ pkgs, helix, ... }: {
  environment = {
    systemPackages = with pkgs; [
      eza
      expect
      gnupg
      gparted
      graphviz
      inxi
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
      helix.packages."${pkgs.system}".helix
    ];
  };
}

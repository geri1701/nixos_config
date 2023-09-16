{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      eza
      expect
      gnupg
      gparted
      graphviz
      helix
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
      sops
      tree
      virt-manager
      vulkan-tools
      wget
      zoxide
    ];
  };
}

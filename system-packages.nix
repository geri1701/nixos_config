{ config, pkgs, ... }: {
  environment = {
    defaultPackages = [ ];
    systemPackages = with pkgs; [
      crate2nix
      exa
      expect
      gnupg
      gparted
      graphviz
      helix
      ifwifi
      inxi
      jq
      libiconv
      libsForQt5.qtstyleplugin-kvantum
      nixfmt
      nixos-option
      nix-prefetch-git
      nushell
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

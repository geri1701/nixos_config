# This file will contain all the system packages from configuration.nix
# It will be imported by the system configuration.
{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
   btrfs-heatmap
    btrfs-progs
    btrfs-snap
    crate2nix
    exa
    expect
    gcc
    git
    glibc
    gnumake
    gnupg
    gopass
    gparted
    graphviz
    helix
    inxi
    jq
    libiconv
    libsForQt5.qtstyleplugin-kvantum
    lynx
    nixfmt
    nixos-option
    nix-prefetch-git
    nushell
    openssl
    perl
    pfetch
    pinentry
    pkgconfig
    age
    rnix-lsp
    rust-analyzer
    rustup
    sshfs
    starship
    sops
    tree
    virt-manager
    vulkan-tools
    wget
    zoxide
];
}

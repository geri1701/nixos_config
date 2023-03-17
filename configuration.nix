# Help is available in the configuration.nix(5) man page
{ sops-nix, config, pkgs, ... }: {
  ### Enable touchpad support (enabled default in most desktopManager).
  ### services.xserver.libinput.enable = true;
  nixpkgs.config.allowUnfree = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # e.g. man configuration.nix or on https://nixos.org/nixos/options.html.
  system.stateVersion = "22.11";
}

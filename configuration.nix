# Help is available in the configuration.nix(5) man page
{ sops-nix, config, pkgs, ... }: {
  systemd.services.mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
  # Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  qt.enable = true;
  qt.platformTheme = "gtk2";
  qt.style = "gtk2";

  ### Enable touchpad support (enabled default in most desktopManager).
  ### services.xserver.libinput.enable = true;

  users.users.geri = {
    isNormalUser = true;
    description = "geri";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  fonts.fonts = with pkgs; [
    dina-font
    fantasque-sans-mono
    fira-code
    fira-code-symbols
    liberation_ttf
    meslo-lg
    mplus-outline-fonts.githubRelease
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    tamsyn
    tamzen
    terminus_font
  ];
  nixpkgs.config.allowUnfree = true;
  users.defaultUserShell = pkgs.zsh;
  security.polkit.enable = true;
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

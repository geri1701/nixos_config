# Help is available in the configuration.nix(5) man page
{ sops-nix, config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
      options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
      options = [ "rw" "noatime" "discard" "nodelalloc" "errors=remount-ro" ];
      neededForBoot = true;
    };
    "/mnt/data" = {
      device = "/dev/disk/by-label/slow";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nodiratime" ];
    };
  };
  environment.sessionVariables.EDITOR = "hx";
  networking = {
    hostName = "zero";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  virtualisation.libvirtd.enable = true;
  systemd.services.sort-att-dir = {
    description = "sort files";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.mkForce (pkgs.writeShellScript "clean_att_dir" ''
        mkdir -p /home/geri/mail_att/gehalt /home/geri/mail_att/rechnung
        shopt -s nocaseglob
        for file in "/home/geri/mail_att"/*{gehalt,rechnung}*; do
            if [[ -f "$file" ]]; then
                if echo "$file" | grep -qi "gehalt"; then
                    mv "$file" "/home/geri/mail_att/gehalt" >/dev/null 2>&1
                elif echo "$file" | grep -qi "rechnung"; then
                    mv "$file" "/home/geri/mail_att/rechnung" >/dev/null 2>&1
                fi
            fi
        done
        shopt -u nocaseglob
      '');
    };
    wantedBy = [ "multi-user.target" ];
  };

  time.timeZone = "Europe/Vienna";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.UTF-8";
      LC_IDENTIFICATION = "de_AT.UTF-8";
      LC_MEASUREMENT = "de_AT.UTF-8";
      LC_MONETARY = "de_AT.UTF-8";
      LC_NAME = "de_AT.UTF-8";
      LC_NUMERIC = "de_AT.UTF-8";
      LC_PAPER = "de_AT.UTF-8";
      LC_TELEPHONE = "de_AT.UTF-8";
      LC_TIME = "de_AT.UTF-8";
    };
  };
  services = {
    openssh = {
      enable = false;
      settings = { PasswordAuthentication = false; };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
  console = { useXkbConfig = true; };
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

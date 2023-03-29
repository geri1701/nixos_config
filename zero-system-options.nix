{ pkgs, lib, ... }: {
  system.stateVersion = "22.11";
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
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
  hardware.pulseaudio.enable = false;
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
  networking = {
    hostName = "zero";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nixpkgs.config.allowUnfree = true;
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
    zsh.enable = true;
  };
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
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
  sound.enable = true;
  systemd.services = {
    mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };
    sort-att-dir = {
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
                  elif echo "$file" | grep -qi  -e "rechnung" -e "invoice"; then
                      mv "$file" "/home/geri/mail_att/rechnung" >/dev/null 2>&1
                  fi
              fi
          done
          shopt -u nocaseglob
        '');
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
  time.timeZone = "Europe/Vienna";
  users = {
    defaultUserShell = pkgs.zsh;
    users.geri = {
      isNormalUser = true;
      description = "geri";
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    libvirtd.enable = true;
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  stylix.image = ./wallpaper_logo.png;
  stylix.polarity = "dark";
  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "Fantasque Sans";
    };

    monospace = {
      package = pkgs.dejavu_fonts;
      name = "Fantasque Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };
  ### Enable touchpad support (enabled default in most desktopManager).
  ### services.xserver.libinput.enable = true;
}

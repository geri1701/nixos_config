# Help is available in the configuration.nix(5) man page
{ sops-nix, config, pkgs, ... }:
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "1prd9b1xx8c0sfwnyzkspplh30m613j42l1k789s521f4kv4c2z2";
  };
  hyprland = (import flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/hyprwm/Hyprland/archive/master.tar.gz";
      sha256 = "0lc26gjx0izd4b2rhysqjj1v14n8zplmkgfjw1a8m90jy385gqbw";
    };
  }).defaultNix;
  cleanup_dir = { };
  # stable-pkgs = import <nixos-stable> { };
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    sha256 = "0zplfvpb0r0x1hjs3zs6v5cwydrgqhm4mi6s8skmnijb5pz6yrqz";
  };
in {
  imports = [
    ./hardware-configuration.nix
    # <home-manager/nixos>
    # (import "${home-manager}/nixos")
    # <sops-nix/modules/sops>
    hyprland.nixosModules.default
  ];
  programs = {
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.default;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
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
  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  #   # users.root = import ./home_root.nix;
  # };
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
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "quiet" ];
    cleanTmpDir = true;
    plymouth.enable = true;
    initrd.systemd.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
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
      ExecStart =
        "/nix/store/kxmgmfwv10r32x9z06a4c2fh2w6p3qf5-system-path/bin/cleanup_dir /home/geri/mail_att /home/geri/mail_att";
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
  systemd.services.mpd.environment = {
    # fix von  https://gitlab.freedesktop.org/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
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
  environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    btrfs-heatmap
    btrfs-progs
    btrfs-snap
    crate2nix
    # cleanup_dir
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
    (pkgs.pidgin.overrideAttrs (oldAttrs: {
      configFile = "~/.purple/accounts.xml";
      configFile1 = "~/.purple/prefs.xml";
    }))
  ];
  ## DEFAULT shell
  #
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
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

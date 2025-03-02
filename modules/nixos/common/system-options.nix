{ config, lib, pkgs, ... }: {
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  hardware.keyboard.qmk.enable = true;
  hardware.brillo.enable = true;
  hardware.i2c.enable = true;
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.commit-mono
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      fira-code-symbols
      liberation_ttf
      nerd-fonts.meslo-lg
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      tamsyn
      tamzen
      iosevka
      iosevka-comfy.comfy
    ];
  };
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs = 4;
      cores = 16;
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true 
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  documentation.man.generateCaches = false;
  documentation.dev.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
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
  programs = {
    wireshark.enable = true;
    wireshark.package = pkgs.wireshark;
    dconf.enable = true;
    steam.enable = true;
    thunar.enable = true;
    kdeconnect.enable = true;
  };
  qt.enable = true;
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  services = {
    pulseaudio.enable = false;
    gvfs.enable = true;
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "geri";
        };
        default_session = initial_session;
      };
    };
    udev.packages = with pkgs; [ via ];
    udev.extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    '';
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    getty = {
      loginOptions = "-p -- geri";
      extraArgs = [ "--noclear" "--skip-login" ];
    };
    gnome.gnome-keyring.enable = true;
    desktopManager.cosmic.enable = false;
    displayManager.cosmic-greeter.enable = false;
    ollama = {
      enable = true;
      acceleration = "rocm";
      environmentVariables = {
        ROCR_VISIBLE_DEVICES = "1";
        # HSA_OVERRIDE_GFX_VERSION = "10.3.0"; 
      };
    };
    systemd.services = {
      mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };
    };
    time.timeZone = "Europe/Vienna";
    users = {
      defaultUserShell = pkgs.fish;
      users.geri = {
        isNormalUser = true;
        description = "geri";
        extraGroups = [
          "i2c"
          "networkmanager"
          "wheel"
          "docker"
          "libvirtd"
          "video"
          "wireshark"
        ];
      };
      users.geri.initialPassword = "firstboot";
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
      config.common.default = "*";
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    stylix = {
      enable = true;
      image = ./wallpaper.png;
      polarity = "dark";
    };
  };
}

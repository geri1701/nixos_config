{ pkgs, lib, ... }: {
  system.stateVersion = "24.05";
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  documentation.man.generateCaches = false;
  fonts =
    {
      fontDir.enable = true;
      packages = with pkgs; [
        commit-mono
        fantasque-sans-mono
        fira-code
        fira-code-symbols
        liberation_ttf
        meslo-lg
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        iosevka
        tamsyn
        tamzen
      ];
    };
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
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs= 4;
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
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    dconf.enable = true;
    starship.enable = true;
    steam.enable = true;
    thunar.enable = true;
    zsh.enable = true;
    kdeconnect.enable = true;
  };
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "kvantum";
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  services = {
    displayManager.ly = { enable = true;
  };
  desktopManager.plasma6.enable = true;
  interception-tools =
  let
    itools = pkgs.interception-tools;
    itools-caps = pkgs.interception-tools-plugins.caps2esc;
  in
  {
    enable = true;
    plugins = [ itools-caps ];
    udevmonConfig = pkgs.lib.mkDefault ''
      - JOB: "${itools}/bin/intercept -g $DEVNODE | ${itools-caps}/bin/caps2esc -m 1 | ${itools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
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
    getty = {
      loginOptions = "-p -- geri";
      extraArgs = [ "--noclear" "--skip-login" ];
    };
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    desktopManager.cosmic.enable = false;
    displayManager.cosmic-greeter.enable = false;
    ollama = {
    enable = false;
    # acceleration = "rocm";
    environmentVariables = {
    # ROCR_VISIBLE_DEVICES= "1";
    HSA_OVERRIDE_GFX_VERSION = "10.3.6"; 
    };
   };
  };
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
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" ];
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
    image = /home/geri/nixos/wallpaper.png;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.commit-mono;
        name = "CommitMono";
      };

      sansSerif = {
        package = pkgs.iosevka;
        name = "CommitMono";
      };

      monospace = {
        package = pkgs.commit-mono;
        name = "CommitMono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

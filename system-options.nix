{ pkgs, lib, ... }: {
  system.stateVersion = "24.05";
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  fonts =
    {
      fontDir.enable = true;
      packages = with pkgs; [
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
      max-jobs= "auto";
      cores = 0;
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
    davfs2.enable = true;
    flatpak.enable = true;
    autofs = {
      enable = true;
      autoMaster =
        let
          mapConf = pkgs.writeText "auto" ''
            nextcloud -fstype=davfs,conf=/path/to/davfs/conf,uid=myuid :https\:nextcloud.nerdbyte.at/remote.php/dav/files/Geri
          '';
        in
        ''
          /home/directory/mounts file:${mapConf}
        '';
    };
    gnome.gnome-keyring.enable = true;
    offlineimap.enable = true;
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
      extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "video" ];
    };
    users.geri.initialPassword = "firstboot";
  };
  virtualisation = {
    # vmVariant = {
    # };
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
    image = ./wallpaper.png;
    polarity = "dark";
    fonts = {
      serif = {
        package = pkgs.iosevka;
        name = "iosevka";
      };

      sansSerif = {
        package = pkgs.tamzen;
        name = "iosevka";
      };

      monospace = {
        package = pkgs.tamzen;
        name = "iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

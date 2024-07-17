{ pkgs, lib, ... }: {
  system.stateVersion = "24.05";
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  documentation.man.generateCaches = false;
  environment.etc = {
  # Creates /etc/nanorc
  path = "cosmic-comp/";
   config.ron = {
    text = ''
    (
    key_bindings: {
        (modifiers: [Super, Shift], key: "Escape"): Terminate,
        (modifiers: [Super, Ctrl], key: "Escape"): Debug,
        (modifiers: [Super], key: "Escape"): Spawn("loginctl lock-session"),
        (modifiers: [Super], key: "q"): Close,

        (modifiers: [Super], key: "1"): Workspace(1),
        (modifiers: [Super], key: "2"): Workspace(2),
        (modifiers: [Super], key: "3"): Workspace(3),
        (modifiers: [Super], key: "4"): Workspace(4),
        (modifiers: [Super], key: "5"): Workspace(5),
        (modifiers: [Super], key: "6"): Workspace(6),
        (modifiers: [Super], key: "7"): Workspace(7),
        (modifiers: [Super], key: "8"): Workspace(8),
        (modifiers: [Super], key: "9"): Workspace(9),
        (modifiers: [Super], key: "0"): LastWorkspace,
        (modifiers: [Super, Shift], key: "1"): MoveToWorkspace(1),
        (modifiers: [Super, Shift], key: "2"): MoveToWorkspace(2),
        (modifiers: [Super, Shift], key: "3"): MoveToWorkspace(3),
        (modifiers: [Super, Shift], key: "4"): MoveToWorkspace(4),
        (modifiers: [Super, Shift], key: "5"): MoveToWorkspace(5),
        (modifiers: [Super, Shift], key: "6"): MoveToWorkspace(6),
        (modifiers: [Super, Shift], key: "7"): MoveToWorkspace(7),
        (modifiers: [Super, Shift], key: "8"): MoveToWorkspace(8),
        (modifiers: [Super, Shift], key: "9"): MoveToWorkspace(9),
        (modifiers: [Super, Shift], key: "0"): MoveToLastWorkspace,

        (modifiers: [Super, Ctrl, Alt], key: "Left"): MoveToOutput(Left),
        (modifiers: [Super, Ctrl, Alt], key: "Down"): MoveToOutput(Down),
        (modifiers: [Super, Ctrl, Alt], key: "Up"): MoveToOutput(Up),
        (modifiers: [Super, Ctrl, Alt], key: "Right"): MoveToOutput(Right),
        (modifiers: [Super, Ctrl, Alt], key: "h"): MoveToOutput(Left),
        (modifiers: [Super, Ctrl, Alt], key: "k"): MoveToOutput(Down),
        (modifiers: [Super, Ctrl, Alt], key: "j"): MoveToOutput(Up),
        (modifiers: [Super, Ctrl, Alt], key: "l"): MoveToOutput(Right),

        (modifiers: [Super], key: "Period"): NextOutput,
        (modifiers: [Super], key: "Comma"): PreviousOutput,
        (modifiers: [Super, Shift], key: "Period"): MoveToNextOutput,
        (modifiers: [Super, Shift], key: "Comma"): MoveToPreviousOutput,

        (modifiers: [Super], key: "Left"): Focus(Left),
        (modifiers: [Super], key: "Right"): Focus(Right),
        (modifiers: [Super], key: "Up"): Focus(Up),
        (modifiers: [Super], key: "Down"): Focus(Down),
        (modifiers: [Super], key: "h"): Focus(Left),
        (modifiers: [Super], key: "j"): Focus(Down),
        (modifiers: [Super], key: "k"): Focus(Up),
        (modifiers: [Super], key: "l"): Focus(Right),
        (modifiers: [Super], key: "u"): Focus(Out),
        (modifiers: [Super], key: "i"): Focus(In),

        (modifiers: [Super, Shift], key: "Left"): Move(Left),
        (modifiers: [Super, Shift], key: "Right"): Move(Right),
        (modifiers: [Super, Shift], key: "Up"): Move(Up),
        (modifiers: [Super, Shift], key: "Down"): Move(Down),
        (modifiers: [Super, Shift], key: "h"): Move(Left),
        (modifiers: [Super, Shift], key: "j"): Move(Down),
        (modifiers: [Super, Shift], key: "k"): Move(Up),
        (modifiers: [Super, Shift], key: "l"): Move(Right),

        (modifiers: [Super], key: "o"): ToggleOrientation,
        (modifiers: [Super], key: "s"): ToggleStacking,
        (modifiers: [Super], key: "y"): ToggleTiling,
        (modifiers: [Super], key: "g"): ToggleWindowFloating,
        (modifiers: [Super], key: "x"): SwapWindow,

        (modifiers: [Super], key: "m"): Maximize,
        (modifiers: [Super], key: "r"): Resizing(Outwards),
        (modifiers: [Super, Shift], key: "r"): Resizing(Inwards),

        (modifiers: [Super], key: "b"): Spawn("xdg-open http://"),
        (modifiers: [Super], key: "f"): Spawn("xdg-open ~"),
        //TODO: ability to select default terminal
        (modifiers: [Super], key: "t"): Spawn("kitty"),

        (modifiers: [Super], key: "a"): Spawn("cosmic-app-library"),
        (modifiers: [Super], key: "w"): Spawn("cosmic-workspaces"),
        (modifiers: [Super], key: "slash"): Spawn("cosmic-launcher"),
        (modifiers: [Super]): Spawn("cosmic-launcher"),
        (modifiers: [Alt], key: "Tab"): Spawn("cosmic-launcher alt-tab"),
        (modifiers: [Super], key: "Tab"): Spawn("cosmic-launcher alt-tab"),

        (modifiers: [], key: "Print"): Spawn("cosmic-screenshot"),

        (modifiers: [], key: "XF86AudioRaiseVolume"): Spawn("amixer sset Master 5%+"),
        (modifiers: [], key: "XF86AudioLowerVolume"): Spawn("amixer sset Master 5%-"),
        (modifiers: [], key: "XF86AudioMute"): Spawn("amixer sset Master toggle"),
        (modifiers: [], key: "XF86AudioMicMute"): Spawn("amixer sset Capture toggle"),
        (modifiers: [], key: "XF86MonBrightnessUp"): Spawn("busctl --user call com.system76.CosmicSettingsDaemon /com/system76/CosmicSettingsDaemon com.system76.CosmicSettingsDaemon IncreaseDisplayBrightness"),
        (modifiers: [], key: "XF86MonBrightnessDown"): Spawn("busctl --user call com.system76.CosmicSettingsDaemon /com/system76/CosmicSettingsDaemon com.system76.CosmicSettingsDaemon DecreaseDisplayBrightness"),
    },
    data_control_enabled: false,
)
    '';

    # The UNIX file mode bits
    mode = "0440";
  };
};

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
  interception-tools =
  let
    itools = pkgs.interception-tools;
    itools-caps = pkgs.interception-tools-plugins.caps2esc;
  in
  {
    enable = true;
    plugins = [ itools-caps ];
    # requires explicit paths: https://github.com/NixOS/nixpkgs/issues/126681
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
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    ollama = {
    enable = true;
    # acceleration = "rocm";
    environmentVariables = {
    # ROCR_VISIBLE_DEVICES= "1";
    HSA_OVERRIDE_GFX_VERSION = "10.3.6"; 
    };
   };
  };
  # sound.enable = true;
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

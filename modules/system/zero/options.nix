{ pkgs, lib, ... }:{
  system.stateVersion = "25.05";
  console = { useXkbConfig = true; };
  environment.sessionVariables.EDITOR = "hx";
  environment.variables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.persistence."/persistent" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/nix"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/libvirt/"
      "/var/cache/libvirt"
      "/var/lib/waydroid"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.geri = {
      directories = [
        "Documents"
        "Downloads"
        "FS-UAE"
        "Music"
        "nixos"
        "nextcloud"
        "Pictures"
        "projects"
        "Videos"
        "exercism"
        "c64share"
        ".cache/direnv"
        ".config/anyrun"
        ".config/cosmic"
        ".config/direnv"
        ".config/discord"
        ".config/etlegacy"
        ".config/exercism"
        ".config/fastfetch"
        ".config/Nextcloud"
        ".config/obsidian"
        ".config/Proton Mail"
        ".config/Proton Pass"
        ".config/vice"
        ".config/weathercrab"
        ".local/share/direnv"
        ".local/share/Steam"
        ".local/share/keyrings"
        ".local/share/zoxide"
        ".local/state/bash"
        ".vst3"
        ".lxvst"
        "ladspa"
        ".zen"
        ".floorp"
        ".etlegacy"
        ".ollama" 
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
      files = [
        ".config/nwg-panel/config"
        ".config/ghostty/config"
        ".config/hyprshade/config.toml"
        ".config/ashell/config.toml"
        ".config/starship.toml"
        ".config/hypr/shaders/reduced-blue-light-filter.glsl"
        ".config/hypr/shaders/m_greendark.glsl"
        ".config/hypr/shaders/m_greenlight.glsl"
        ".config/hypr/shaders/m_reddark.glsl"
        ".config/hypr/shaders/m_redlight.glsl"
        ".config/hypr/shaders/m_monochrome_black.glsl"
        ".config/hypr/shaders/soft_grayscale.glsl"
        ".config/hypr/shaders/phosphor_green.glsl"
        ".config/hypr/shaders/amber_terminal.glsl"
        ".config/hypr/shaders/astronomer_red.glsl"
        ".config/hypr/shaders/paper_mode.glsl"
        ".config/hypr/shaders/eye_friendly_amber.glsl"
        ".config/hypr/shaders/eye_friendly_phosphor.glsl"
        ".config/hypr/shaders/eye_friendly_paper.glsl"
        ".config/clipse/clipboard_history.json"
        ".config/hyprpanel/config.json"
        ".config/nap/config.yaml"
        ".config/uwsm/env"
        ".inputrc"
        ".bash_history"
      ];
    };
  };
  # documentation.man.generateCaches = false;
  # documentation.dev.enable = true;
  programs.bash.completion.enable = true;
  programs.nix-ld.enable = true;
  programs.light.enable = true;
  programs.hyprland.withUWSM = true;
  home-manager.users.geri.nixpkgs.config.allowUnfree = true;
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
    noto-fonts-color-emoji
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    tamsyn
    tamzen
    iosevka
    iosevka-comfy.comfy
  ];
};
  services.open-webui = {
    enable = true;
    host = "127.0.0.1";
    port = 8080;
    environment = {
      OLLAMA_API_BASE = "http://127.0.0.1:11434";
      DATA_DIR = "/persistent/var/lib/open-webui";
      WEBUI_AUTH = "false";
      WEBUI_NAME = "Zero WebUI";
      RAG_OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      RAG_EMBEDDING_ENGINE = "ollama";
      RAG_EMBEDDING_MODEL = "nomic-embed-text";
      ENABLE_RAG_HYBRID_SEARCH = "true";
      USER_PERMISSIONS_WORKSPACE_TOOLS_ACCESS = "true";
      USER_PERMISSIONS_WORKSPACE_TOOLS_IMPORT = "true";
      USER_PERMISSIONS_WORKSPACE_TOOLS_EXPORT = "true";
      USER_PERMISSIONS_FEATURES_DIRECT_TOOL_SERVERS = "true";
      ENABLE_WEB_SEARCH = "true";
      WEB_SEARCH_ENGINE = "duckduckgo";
      WEB_SEARCH_RESULT_COUNT = "3";
      WEB_SEARCH_CONCURRENT_REQUESTS = "2";
    };
  };
  systemd.services.open-webui = {
    serviceConfig = {
      DynamicUser = lib.mkForce false;
      User = "ollama";
      Group = "ollama";
      ReadWritePaths = "/persistent/var/lib/open-webui";
    };
  };
  systemd.tmpfiles.rules = [
    "d /persistent/var/lib/open-webui/data/tools 0755 ollama ollama - -"
    "d /persistent/var/lib/open-webui/data/prompts 0755 ollama ollama - -"
    "C+ /persistent/var/lib/open-webui/data/tools/file_system_operations.py 0644 ollama ollama - /home/geri/nixos/modules/system/zero/open-webui/tools/file_system_operations.py"
    "C+ /persistent/var/lib/open-webui/data/prompts/system-prompt-generator.md 0644 ollama ollama - /home/geri/nixos/modules/system/zero/open-webui/prompts/system-prompt-generator.md"
  ];
  services.desktopManager.cosmic.enable = false;
  services.displayManager.cosmic-greeter.enable = false;
  services.desktopManager.cosmic.xwayland.enable = false;
  services.pulseaudio.enable = false;
  services.gvfs.enable = true;
  hardware.keyboard.qmk.enable = true;
  hardware.brillo.enable = true;
  hardware.i2c.enable = true;
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
    wireshark.enable = true;
    wireshark.package = pkgs.wireshark;
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
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;

    sudo.enable = false;
    sudo-rs.enable = true;

    sudo-rs.extraRules = [
      {
        users = [ "geri" ];
        commands = [
          {
            command = "/etc/profiles/per-user/geri/bin/comfyui-drop-caches";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
  services = {
    udev.packages = with pkgs; [ via ];
    udev.extraRules = ''
      KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
      ACTION=="add|change", KERNEL=="sd[a-z]*[0-9]*|mmcblk[0-9]*p[0-9]*|nvme[0-9]*n[0-9]*p[0-9]*", ENV{ID_FS_TYPE}=="ext4", ATTR{../queue/scheduler}="none"
    '';
    # displayManager.ly = { enable = false;
   # };
  desktopManager.plasma6.enable = false;
    pipewire = {
      enable = true;
      audio.enable = true;
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
    gnome.gnome-keyring.enable = true;
    # displayManager.cosmic-greeter.enable = false;
    ollama = {
      home = "/persistent/var/lib/ollama";
      user = "ollama";
      group = "ollama";
      enable = true;
      package = pkgs.ollama-rocm;
      environmentVariables = {
        ROCR_VISIBLE_DEVICES = "0";
      };
      models = "/persistent/var/lib/ollama/.ollama/models";
      loadModels = [ "qwen3:14b" "gemma3:12b" "dolphin3" "nomic-embed-text" ];
    };
  };
  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;
  systemd.services = {
    mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };
  };
  time.timeZone = "Europe/Vienna";
  users = {
    defaultUserShell = pkgs.bashInteractive;
    users.geri = {
      isNormalUser = true;
      description = "geri";
      extraGroups = [ "i2c" "networkmanager" "wheel" "docker" "libvirtd" "video" "wireshark" ];
    };
    users.geri.hashedPasswordFile = "/persistent/pwd/geri";
    users.root.hashedPasswordFile = "/persistent/pwd/root";
  };
  virtualisation = {
    waydroid.enable = true;
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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.kdePackages.xdg-desktop-portal-kde ];
  };
  stylix = {
    enable = true;
    image = ../../home/geri/assets/wallpaper.png;
    polarity = "dark";
  };
}

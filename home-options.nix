{ lib, pkgs, ... }: {
  home.pointerCursor.hyprcursor.enable = true;
  home.pointerCursor.name = lib.mkForce "BreezeX-RosePine-Linux";
  home.pointerCursor.package = lib.mkForce pkgs.rose-pine-cursor;
  home.pointerCursor.gtk.enable = true;
  home.pointerCursor.size = lib.mkDefault 24;
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  home = {
    stateVersion = "24.05";
    username = "geri";
    homeDirectory = "/home/geri";
    sessionVariables = {
      EDITOR = "hx";
      TERM = "ghostty";
      MOZ_ENABLE_WAYLAND = 1;

    };
  };
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv = { enable = true; };
    };
    skim.enable = true;
    bottom.enable = true;
    zsh.enable = true;
    zoxide.enable = true;
    starship.enable = true;
    command-not-found.enable = false;
  };
  qt = {
    enable = true;
  };
  services = {
   flameshot = {
      package = (pkgs.flameshot.override { enableWlrSupport = true; });
      enable = true;
      settings.General = {
      showStartupLaunchMessage = false;
      saveLastRegion = true;
     };
   };
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSshSupport = true;
      enableExtraSocket = true;
    };
    network-manager-applet.enable = false;
    mpd = {
      enable = true;
      musicDirectory = "~/music";
      extraConfig = ''
        audio_output {
            type "pulse"
            name "My Pulse Output"
        }
      '';
    };
    dunst = { enable = true; };
    pasystray.enable = false;
    gnome-keyring.enable = true;
  };
  stylix = {
    enable = true;
    autoEnable = false;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ./wallpaper.png;
    polarity = "dark";
    cursor.size = 24;
    targets = {
      helix.enable = true;
      kde.enable = false;
      vscode.enable = false;
      gtk.enable = true;
    };
    fonts.sizes.terminal = 14;
  };
  xdg = {
   enable = true;
   desktopEntries = {
   steam-dgpu = {
      name = "steam-dgpu";
      exec = "DRI_PRIME=1 steam steam://open/games";
      terminal = false;
    };
   };
  };
 }

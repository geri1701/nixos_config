{ lib, pkgs, ... }: {
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
    pointerCursor = {
      hyprcursor.enable = true;
      name = lib.mkForce "BreezeX-RosePine-Linux";
      package = lib.mkForce pkgs.rose-pine-cursor;
      gtk.enable = true;
      # size = lib.mkDefault 24;
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
    gpg-agent = {
      enable = true;
      pinentry = {
        package = pkgs.pinentry-gnome3;
      };
      enableSshSupport = true;
      enableExtraSocket = true;
    };
    network-manager-applet.enable = false;
    pasystray.enable = false;
    gnome-keyring.enable = true;
  };
  stylix = {
    enable = true;
    autoEnable = false;
    image = ./assets/wallpaper.png;
    polarity = "dark";
    cursor.size = 24;
    cursor.name = "BreezeX-RosePine-Linux";
    cursor.package = pkgs.rose-pine-cursor;
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
  };
 }

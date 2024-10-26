{ lib, pkgs, ... }: {
    # home-manager.backupFileExtension = "backup";
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
      TERM = "foot";
      # QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
      # GTK_USE_PORTAL = 1;
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
    # platformTheme.name = "gtk2";
  };
  services = {
    gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
      enableSshSupport = true;
      enableExtraSocket = true;
    };
    network-manager-applet.enable = true;
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
    pasystray.enable = true;
    gnome-keyring.enable = true;
  };
  stylix = {
    targets = {
      helix.enable = true;
      vscode.enable = false;
      waybar.enable = true;
    };
    fonts.sizes.terminal = 10;
  };
  xdg = { enable = true; };
}

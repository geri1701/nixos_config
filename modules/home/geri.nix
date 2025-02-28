{ config, pkgs, lib, ... }:

{
  # Home Manager benötigt eine Versionsangabe zur Kompatibilität
  home = {
    stateVersion = "23.11";
    username = "geri";
    homeDirectory = "/home/geri";
    pointerCursor= {
      hyprcursor.enable = true;
      name = lib.mkForce "BreezeX-RosePine-Linux";
      package = lib.mkForce pkgs.rose-pine-cursor;
      gtk.enable = true;
      size = lib.mkDefault 24;
    };
    sessionVariables = {
      EDITOR = "hx";
      TERM = "ghostty";
      MOZ_ENABLE_WAYLAND = 1;
    };
  };
  # Einbinden gemeinsamer Home-Module
  imports = [
    ../common/home-options.nix
    ../common/home-packages.nix
    ../common/host-options.nix
    ../home/programs/helix.nix
  ];

  # Programme aktivieren
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
    };
    fish.enable = true; # Hier weitermachen!!
    starship.enable = true;
  };
  # Firefox Einstellungen setzen (unterstützt HiDPI durch host-spezifische Option)
  programs.firefox = {
    enable = true;
    profiles.default.settings = {
      "layout.css.devPixelsPerPx" = config.firefoxPixelsPerPxOption; # Setzt HiDPI-Skalierung
    };
  };

  # Terminal-Farben/Themes
  stylix.enable = true;


  # Wallpaper setzen, falls von Hyprland/Waybar benötigt
  xdg.configFile."wallpaper.png".source = ../../wallpaper.png;

  # Home-Manager Packages für diesen Benutzer
  home.packages = with pkgs; [
    neovim
    kitty
    keepassxc
    firefox
    thunderbird
    zellij
    yt-dlp
    fastfetch
    lazygit
    ripgrep
    fzf
  ];

  # XDG Portals für Desktop-Anwendungen (z.B. für Wayland)
  xdg.portal.enable = true;
}



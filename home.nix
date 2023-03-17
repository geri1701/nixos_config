{ pkgs, ... }: {
  services = {
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
    dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#586e75";
          font = "Droid Sans 9";
        };

        urgency_normal = {
          background = "#073642";
          foreground = "#93a1a1";
          timeout = 10;
        };
      };
    };
    pasystray.enable = true;
    gnome-keyring.enable = true;
  };
  gtk = {
    enable = true;
    font.name = "Victor Mono SemiBold 12";
    theme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
    iconTheme = {
      name = "material-black";
      package = pkgs.tela-icon-theme;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

}

{ pkgs, ... }: {
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

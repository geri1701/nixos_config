{
  home.file.".config/zellij/layouts/default.kdl" = {
    recursive = true;
    text = ''
      layout {
          default_tab_template {
              pane size=1 borderless=true {
                  plugin location="zellij:tab-bar"
              }
              children
              pane size=2 borderless=true {
                  plugin location="zellij:status-bar"
              }
          }
          tab
          tab split_direction="Vertical" {
              pane split_direction="Vertical" {
                  pane
                  pane
              }
          }
          tab split_direction="Vertical" {
              pane split_direction="Vertical" {
                  pane split_direction="Horizontal" {
                      pane
                      pane size="60%"
                  }
                  pane size="60%" focus=true
              }
          }
      } '';
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "solarized-dark";
      copy_command = "wl-copy";
      copy_clipboard = "primary";
      scrollback_editor = "hx";
      plugins = {
        tab-bar = { path = "tab-bar"; };
        status-bar = { path = "status-bar"; };
        strider = { path = "strider"; };
      };
      ui = { pane_frames = { rounded_corners = true; }; };
      themes = {
        solarized-dark = {
          fg = "#fdf6e3";
          bg = "#002b36";
          black = "#073642";
          red = "#dc322f";
          green = "#859900";
          yellow = "#b58900";
          blue = "#268bd2";
          magenta = "#d33682";
          cyan = "#2aa198";
          white = "#eee8d5";
          orange = "#cb4b16";
        };
      };
    };
  };
}

{ pkgs, ... }: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general = { unsafe-accounts-conf = true; };
      ui = {
        styleset-name = "solarized";
        timestamp-format = "02 Jan 06 15:04:05";
      };
      viewer = { alternatives = "text/html,text/plain"; };
      filters = {
        "text/plain" = "cat";
        "text/html" = "w3m -dump -I UTF-8 -T text/html";
        "image/*" = "img2sixel $(tput cols) -";
      };
    };
    extraAccounts = {
      gmx = {
        source = "imaps://gschwa%40gmx.net@imap.gmx.net:993";
        outgoing = "smtp+plain://gschwa%40gmx.net@mail.gmx.net:587";
        default = "INBOX";
        smtp-starttls = "yes";
        source-cred-cmd =
          "cat /run/user/1000/secrets/$(realify --config ~/realify.conf --name gmx)";
        outgoing-cred-cmd =
          "cat /run/user/1000/secrets/$(realify --config ~/realify.conf --name gmx)";
        from = "Gerhard <gschwa@gmx.net>";
        copy-to = "Sent";
      };
      sdf = {
        source = "imaps://geri@mx.sdf.org:993";
        outgoing = "smtp+plain://geri@mx.sdf.org:587";
        default = "INBOX";
        smtp-starttls = "yes";
        source-cred-cmd =
          "cat /run/user/1000/secrets/$(realify --config ~/realify.conf --name sdf)";
        outgoing-cred-cmd =
          "cat /run/user/1000/secrets/$(realify --config ~/realify.conf --name sdf)";
        from = "Gerhard <geri@sdf.org>";
        copy-to = "Sent";
      };
    };
    stylesets = {
      solarized = ''
        *.default=true
        *error.bold=true
        border.reverse=true
        completion_pill.reverse=true
        error.fg=#dc322f
        header.bold=true
        selector_chooser.bold=true
        statusline*.default=true
        success.fg=#859900
        warning.fg=#b58900
        *.selected.bg=#b58900
        *.selected.fg=#3b4252
        dirlist_recent.fg=#b58900
        dirlist_unread.fg=#b58900
        msglist_flagged.bold=true
        msglist_flagged.fg=#a3be8c
        msglist_marked.bg=#81a1c1
        msglist_unread.fg=#b58900
        msglist_unread.selected.bg=#b58900
        msglist_unread.selected.fg =#002b36
        statusline_*.bg=#859900
        statusline_*.fg=#002b36
        statusline_error.bg=#d33682
        statusline_error.fg=#002b36
        tab.bg=#eee8d5
        tab.fg=#586e75
        tab.selected.bg=#b58900
        tab.selected.fg=#002b36
        [viewer]
        diff_add.fg=#859900
        diff_chunk.dim=true
        diff_chunk.fg=#2aa198
        diff_del.fg=#dc322f
        diff_meta.bold=true
        diff_meta.fg=#839496
        header.bold=true
        header.fg=#d33682
        quote_*.dim=true
        quote_*.fg=#93a1a1
        quote_1.dim=false
        quote_1.fg=#268bd2
        quote_2.fg=#cb4b16
        quote_3.fg=#d33682
        quote_4.fg=#6c71c4
        signature.dim=true
        signature.fg=#d33682
        url.fg=#b58900
        url.underline=true
      '';
    };
  };
}

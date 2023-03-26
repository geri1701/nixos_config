{ pkgs, ... }: {
  programs.aerc = {
    enable = true;
    extraConfig = {
      general = { unsafe-accounts-conf = true; };
      ui = {
        styleset-name = "styleset";
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
        source-cred-cmd = "cat /run/user/1000/secrets/gmx";
        outgoing-cred-cmd = "cat /run/user/1000/secrets/gmx";
        from = "Gerhard <gschwa@gmx.net>";
        copy-to = "Sent";
      };
      sdf = {
        source = "imaps://geri@mx.sdf.org:993";
        outgoing = "smtp+plain://geri@mx.sdf.org:587";
        default = "INBOX";
        smtp-starttls = "yes";
        source-cred-cmd = "cat /run/user/1000/secrets/sdf";
        outgoing-cred-cmd = "cat /run/user/1000/secrets/sdf";
        from = "Gerhard <geri@sdf.org>";
        copy-to = "Sent";
      };
    };
  };
}

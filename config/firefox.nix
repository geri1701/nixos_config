{ config, ... }: {
  programs.firefox = {
    enable = true;
    profiles.geri.settings = {
      "media.ffmpeg.vaapi.enabled" = true;
      "gfx.webrender.all" = true;
      "browser.download.start_downloads_in_tmp_dir" = true;
      "layout.css.devPixelsPerPx" = "${config.firefoxPixelsPerPxOption}";
      "extensions.webextensions.tabhide.enabled" = true;
      "browser.startup.homepage" = "https://duckduckgo.com/";
      "browser.sessionstore.resume_from_crash" = false;
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
  };
}

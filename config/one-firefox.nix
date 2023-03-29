{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
    profiles.geri.settings = {
      "media.ffmpeg.vaapi.enabled" = true;
      "gfx.webrender.all" = true;
      "browser.download.start_downloads_in_tmp_dir" = true;
      "layout.css.devPixelsPerPx" = "1.5";
      "extensions.webextensions.tabhide.enabled" = true;
      "browser.startup.homepage" = "localhost:9090/bookmarks";
      "browser.sessionstore.resume_from_crash" = false;
    };
  };
}

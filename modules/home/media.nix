{pkgs, ...}: {
  # Stylix themes mpv. imv stays stock

  # imv gets the file's directory, so n and p cycle the neighbors
  programs.imv.enable = true;

  # MPRIS for playerctl keys and the noctalia media widget
  programs.mpv = {
    enable = true;
    scripts = [pkgs.mpvScripts.mpris];
    config = {
      vo = "gpu-next";
      hwdec = "auto-safe"; # GPU decode when available, else CPU
      keep-open = "yes";
      save-position-on-quit = "yes";
    };
  };

  xdg.mimeApps.defaultApplications = let
    imv = "imv-dir.desktop";
    mpv = "mpv.desktop";
  in {
    "image/jpeg" = imv;
    "image/png" = imv;
    "image/gif" = imv;
    "image/webp" = imv;
    "image/bmp" = imv;
    "image/tiff" = imv;
    "image/avif" = imv;
    "image/svg+xml" = imv;
    "image/jxl" = imv;
    "image/heif" = imv;
    "image/heic" = imv;

    "audio/mpeg" = mpv;
    "audio/flac" = mpv;
    "audio/x-wav" = mpv;
    "audio/ogg" = mpv;
    "audio/opus" = mpv;
    "audio/aac" = mpv;
    "audio/mp4" = mpv;

    "video/mp4" = mpv;
    "video/x-matroska" = mpv;
    "video/webm" = mpv;
    "video/quicktime" = mpv;
    "video/x-msvideo" = mpv;
    "video/mpeg" = mpv;
  };
}

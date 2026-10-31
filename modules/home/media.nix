{...}: {
  # Image viewer and media player. Stylix themes mpv's OSD out of the box but
  # has no imv target, so imv stays stock.

  # imv: minimal Wayland image viewer. imv-dir opens the file's directory so
  # n/p cycle the neighbors.
  programs.imv.enable = true;

  # mpv: video and audio player. MPRIS so playerctl keys and noctalia's media
  # widget see it.
  programs.mpv = {
    enable = true;
    scripts = [pkgs.mpvScripts.mpris];
    config = {
      hwdec = "auto-safe"; # GPU decode when the driver supports it, else CPU.
      keep-open = "yes"; # Don't close the window when a file ends.
      save-position-on-quit = "yes"; # Resume long videos where you left off.
    };
  };

  # zed.nix sets `xdg.mimeApps.enable` and claims text/*; attrsets merge, so
  # only image/audio/video associations are added here.
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

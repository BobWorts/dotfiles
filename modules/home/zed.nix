{
  lib,
  pkgs,
  ...
}: {
  # Stylix owns fonts, but its theme is bypassed. Kanagawa Wave comes from
  # the extension below
  programs.zed-editor = {
    enable = true;

    extensions = [
      "kanagawa-themes"
      "catppuccin-icons"
      "nix"
      "html"
    ];

    userSettings = {
      # Stylix also writes a theme, hence mkForce
      theme = lib.mkForce "Kanagawa Wave";

      icon_theme = "Catppuccin Frappé";

      auto_update = false;

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Direct skips the shell round trip for direnv
      load_direnv = "direct";
    };
  };

  # Upstream reuses the current window, this one opens a new window
  xdg.desktopEntries."zed-new-window" = {
    name = "Zed (new window)";
    genericName = "Text Editor";
    exec = "zeditor --new %U";
    icon = "zed";
    type = "Application";
    startupNotify = true;
    categories = ["Utility" "TextEditor" "Development" "IDE"];
    mimeType = ["text/plain" "application/x-zerosize" "x-scheme-handler/zed"];
  };

  # These win over Zen. html and json stay with Zen
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      zed = "zed-new-window.desktop";
    in {
      "text/plain" = zed;
      "text/markdown" = zed;
      "text/x-readme" = zed;
      "text/x-python" = zed;
      "text/x-shellscript" = zed;
      "text/x-csrc" = zed;
      "text/x-chdr" = zed;
      "text/rust" = zed;
      "application/x-shellscript" = zed;
      "application/toml" = zed;
      "application/x-yaml" = zed;
      "application/xml" = zed;
    };
  };

  home.packages = [
    (pkgs.runCommandLocal "zed-cmd" {} ''
      mkdir -p $out/bin
      ln -s ${lib.getExe pkgs.zed-editor} $out/bin/zed
    '')
  ];
}

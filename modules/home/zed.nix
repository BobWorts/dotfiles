{
  lib,
  pkgs,
  ...
}: {
  # Zed, the GUI editor and default handler for text files. Stylix syncs the
  # fonts, but its generated theme is harsh, so we force the hand-tuned
  # "Kanagawa Wave" from the extension below (declared so it installs).
  programs.zed-editor = {
    enable = true;

    # Auto-installed from the Zed extension registry.
    extensions = [
      "kanagawa-themes"
      "catppuccin-icons"
      "nix"
      "html"
    ];

    userSettings = {
      # mkForce: the Stylix zed target also sets `theme`.
      theme = lib.mkForce "Kanagawa Wave";

      icon_theme = "Catppuccin Frappé";

      auto_update = false;

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Load the project's direnv environment when a folder is opened cold.
      load_direnv = "direct";
    };
  };

  # Upstream's .desktop reuses the existing window; ours adds --new so
  # Nautilus double-clicks land in a fresh window.
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

  # Text files go to Zed. Zen also claims text/plain via mkDefault, so these
  # plain assignments win; html and json deliberately stay with Zen.
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

  # Ship a `zed` command alias for the zeditor binary.
  home.packages = [
    (pkgs.runCommandLocal "zed-cmd" {} ''
      mkdir -p $out/bin
      ln -s ${pkgs.zed-editor}/bin/zeditor $out/bin/zed
    '')
  ];
}

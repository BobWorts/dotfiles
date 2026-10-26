{pkgs, ...}: {
  # One palette to rule them all. Stylix derives colors for niri, noctalia,
  # kitty, bat, btop, GTK/Qt and more from a single base16 scheme.
  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = ../../themes/kanagawa.yaml;
    image = ../../themes/wallpaper.png;

    # A hint of terminal transparency for that layered desktop look.
    # 0.95 looks good for pure transparency
    # 0.85 with blur enabled in WM
    opacity.terminal = 0.95;

    # Don't style GTK source view, as it currently triggers binary cache misses -> long rebuilds
    # https://github.com/nix-community/stylix/issues/2318
    targets.gtksourceview.enable = false;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
        popups = 11;
      };
    };
  };
}

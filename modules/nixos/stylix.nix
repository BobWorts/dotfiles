{pkgs, ...}: {
  # Stylix derives colors for niri, noctalia, kitty, bat, btop and GTK apps
  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = ../../themes/kanagawa.yaml;
    image = ../../themes/wallpaper.png;

    # 0.95 for transparency, 0.85 when the compositor blurs
    opacity.terminal = 0.95;

    # Disabled until this cache issue is fixed
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

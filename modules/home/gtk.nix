{pkgs, ...}: {
  # Icon theme for GTK apps. Stylix paints GTK colors and fonts but leaves icons
  # alone; Papirus-Dark keeps its stock blue folders, close to Kanagawa's blue.
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}

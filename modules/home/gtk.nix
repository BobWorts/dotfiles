{pkgs, ...}: {
  # Stylix does not set icons, so use Papirus
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
}

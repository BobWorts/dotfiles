{pkgs, ...}: {
  # Stylix leaves icons alone, so they are set here.
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}

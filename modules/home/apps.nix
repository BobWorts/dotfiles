{
  pkgs,
  inputs,
  ...}: {
  imports = [inputs.zen-browser.homeModules.beta];

  # Registers the mime associations, exports $BROWSER and exposes the profile
  # for Stylix.
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };
  stylix.targets.zen-browser.profileNames = ["default"];

  # File manager; gvfs (desktop.nix) adds trash, mounting, the file picker.
  home.packages = [pkgs.nautilus];

  # Standard ~/Documents, ~/Downloads, ... for Nautilus and screenshots.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # "Open containing folder" lands in Nautilus.
  xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
}

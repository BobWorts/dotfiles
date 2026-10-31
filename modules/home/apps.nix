{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  home.packages = [
    # gvfs (modules/nixos/desktop.nix) adds trash + mounting. The gtk portal
    # uses it as the file picker.
    pkgs.nautilus
  ];

  # Standard ~/Documents, ~/Downloads, ~/Pictures, ... for the Nautilus
  # sidebar and Noctalia's screenshot directory.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # "Open containing folder" and friends should land in Nautilus.
  xdg.mimeApps.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";

  # The module (not just the package) registers the mime associations, exports
  # $BROWSER, and exposes the profile for Stylix theming.
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  # Themes Zen's chrome and about:/newtab pages with the Kanagawa palette.
  stylix.targets.zen-browser.profileNames = ["default"];
}

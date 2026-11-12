{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    profiles.default = {};
  };
  stylix.targets.zen-browser.profileNames = ["default"];

  stylix.targets.rofi.enable = false;

  home.packages = [
    pkgs.nautilus
    pkgs.telegram-desktop
  ];

  xdg.userDirs.createDirectories = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
  };
}

{pkgs, ...}: {
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
  };

  hardware.graphics = [
    enable = true;
    enable32Bit = true;
  ]

  # Trash and mount support for Nautilus
  services.gvfs.enable = true;

  # GTK settings backend
  programs.dconf.enable = true;

  # Auth dialogs in Noctalia and Nautilus. pkexec is needed for admin URIs
  security.polkit.enable = true;
  security.polkit.enablePkexecWrapper = true;

  # Nautilus content search
  services.gnome.localsearch.enable = true;

  # Present for every user
  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    wl-clipboard
    libnotify
    xdg-utils
  ];
}

{pkgs, ...}: {
  # 32-bit GL for Steam/Wine. The `enable` half is turned on by niri-flake.
  hardware.graphics.enable32Bit = true;

  # Trash + mounting for Nautilus.
  services.gvfs.enable = true;

  # A handful of GUI essentials live at the system level so they're always
  # present regardless of which user logs in.
  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    wl-clipboard
    libnotify
    xdg-utils
  ];
}

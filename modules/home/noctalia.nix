{
  pkgs,
  inputs,
  ...
}: {
  # The Noctalia desktop shell: bar, launcher, notifications, control center,
  # lock screen and wallpaper, all in one. Colors follow Stylix.
  programs.noctalia = {
    enable = true;

    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Run as a systemd user service tied to the graphical (niri) session so it
    # starts and stops with your login.
    systemd.enable = true;

    # Configure the rest interactively via its control center (Mod+Space →
    # settings) and, once you're happy, pin values here (schema at
    # docs.noctalia.dev).
    # Switcher: compact strip of window cards instead of the carousel.
    settings.shell.window_switcher.style = "compact";
    # Needed because the shell itself runs as a systemd user unit: apps launched
    # from it then survive a shell restart instead of dying with it.
    settings.shell.launch_apps_as_systemd_services = true;
  };
}

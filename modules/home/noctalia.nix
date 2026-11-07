{...}: {
  # Stylix owns colors
  programs.noctalia = {
    enable = true;

    # User service, stops at logout
    systemd.enable = true;

    # Integration only. Bar, widgets and wallpaper are tuned in the control
    # center and stored in ~/.local/state/noctalia/settings.toml, which wins
    # over this file without a rebuild. Schema: docs.noctalia.dev
    settings.shell.window_switcher.style = "compact";

    # Apps launched by the shell survive a shell restart
    settings.shell.launch_apps_as_systemd_services = true;

    # Noctalia answers auth prompts. The niri-flake agent is masked in
    # modules/nixos/niri.nix
    settings.shell.polkit_agent = true;
  };
}

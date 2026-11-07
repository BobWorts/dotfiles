{
  pkgs,
  inputs,
  local,
  lib,
  ...
}: {
  programs.niri.enable = true;

  # Prebuilt from niri.cachix.org. The module passes it to home-manager
  programs.niri.package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;

  # Only one polkit agent may run. Noctalia ships the themed one
  systemd.user.services.niri-flake-polkit.enable = false;

  # GTK adds the file chooser, niri-flake already brings GNOME
  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
    };
  };

  services.greetd = {
    enable = true;
    settings = lib.mkMerge [
      {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = "greeter";
        };
      }
      (lib.mkIf (local.autoLogin or false) {
        initial_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
          user = local.username;
        };
      })
    ];
  };
}

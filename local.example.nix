# Personal machine settings. Copy to local.nix and fill it in
{
  username = "example";
  hostName = "example";
  fullName = "Your Name"; # Account description

  autoLogin = false;

  timeZone = "UTC";

  # System locale and language
  locale = "en_US.UTF-8";

  # Git identity
  gitUserName = "Your Name";
  gitUserEmail = "you@example.com";

  # Keyboard layouts for the system and niri, comma separated
  # Names are in evdev.lst under `! layout`
  keyboardLayouts = "us,ru";

  # XKB options, comma-separated ("grp:..." style). Popular ones:
  #   grp: alt_shift_toggle (Alt+Shift switches), ctrl_shift_toggle,
  #        caps_toggle, win_space_toggle, alt_space_toggle
  #   caps: swapescape, ctrl_modifier      ctrl: nocaps
  #   compose: ralt, menu                  lv3: ralt_switch, enter_switch
  # Full list: man 7 xkeyboard-config or /usr/share/X11/xkb/rules/evdev.lst
  keyboardOptions = "grp:alt_shift_toggle";

  # Per monitor outputs. Names come from `niri msg outputs`, the rest is
  # automatic. Popular options:
  #   scale: 1.0, or 1.25 / 1.5 / 2.0 for HiDPI
  #   mode: width, height and refresh, null refresh picks the best
  #   position: x and y in logical pixels, 0,0 is the top left
  #   transform: rotation 0/90/180/270, flipped mirrors it
  #   variable-refresh-rate: true, false or "on-demand"
  #   focus-at-startup: true for the main monitor
  # Full list: https://github.com/YaLTeR/niri/wiki/Configuration:-Outputs
  # outputs = {
  #   "eDP-1" = {
  #     mode = { width = 2880; height = 1800; };
  #     scale = 1.5;
  #   };
  #   "HDMI-A-1" = {
  #     mode = { width = 1920; height = 1080; };
  #     position = { x = 1920; y = 0; };
  #   };
  # };

  useQEMU = false;

  useDev = false;
}

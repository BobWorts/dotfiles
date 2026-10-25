# Personal, machine-local settings.
# Copy to `local.nix` (gitignored) and fill in your real values.
{
  # Login user and machine identity.
  username = "example";
  hostName = "example";
  fullName = "Your Name"; # Shown as the user account description

  # Locale / location.
  timeZone = "UTC";

  # Git identity (modules/home/git.nix).
  gitUserName = "Your Name";
  gitUserEmail = "you@example.com";

  # Keyboard layouts shared by the system and niri.
  # Comma-separated keymaps: "us", "us,ru", "gb,de", ... (all: evdev.lst "! layout").
  keyboardLayouts = "us,ru";

  # XKB options, comma-separated ("grp:..." style). Popular ones:
  #   grp: alt_shift_toggle (Alt+Shift switches), ctrl_shift_toggle,
  #        caps_toggle, win_space_toggle, alt_space_toggle
  #   caps: swapescape, ctrl_modifier      ctrl: nocaps
  #   compose: ralt, menu                  lv3: ralt_switch, enter_switch
  # Full list: man 7 xkeyboard-config or /usr/share/X11/xkb/rules/evdev.lst.
  keyboardOptions = "grp:alt_shift_toggle";

  useQEMU = false; # QEMU/KVM VMs: libvirtd + virt-manager
}

{...}: {
  programs.kitty = {
    enable = true;

    settings = {
      cursor_shape = "beam";
      # Delay before the cursor trail animates
      cursor_trail = 10;

      scrollback_lines = 10000;
      confirm_os_window_close = "0";
      update_check_interval = 0;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
    };
  };
}

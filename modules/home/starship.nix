{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = false;

    settings = {
      command_timeout = 1000;

      # Stylix owns colors, the prompt character is fixed
      format = "$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      cmd_duration = {
        format = "[ $duration]($style) ";
      };
    };
  };
}

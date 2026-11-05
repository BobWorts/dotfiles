{...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
    config.hide_env_diffs = true;
  };
}

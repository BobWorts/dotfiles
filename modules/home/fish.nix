{pkgs, ...}: {
  # nix-shell starts bash. any-nix-shell switches it to fish
  home.packages = [pkgs.any-nix-shell];

  programs.fish = {
    enable = true;

    # Abbreviations. lsd provides ls, ll, la and lt. lg is lazygit
    shellAbbrs = {
      cat = "bat";
      top = "btop";
      du = "dust";
      df = "duf";
      ps = "procs";
      ping = "gping";
      g = "git";

      rebuild = "nh os switch";
      update = "nh os switch --update";
    };

    # Transience needs starship loaded first, so both lines live here
    interactiveShellInit = ''
      set -g fish_greeting

      ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source

      starship init fish | source
      enable_transience
    '';
  };

  home.sessionVariables.EDITOR = "nano";
}

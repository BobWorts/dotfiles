{
  pkgs,
  username,
  ...
}: {
  programs.lsd = {
    enable = true;
    settings = {
      date = "relative";
    };
  };

  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
  programs.jq.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"]; # keep the cd command name
  };

  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };

  home.packages = with pkgs; [
    procs # ps replacement
    dust # du replacement
    duf # df replacement
    gping # Ping with a graph

    nix-output-monitor # nh picks it up for pretty build output
    alejandra # nix formatter
    devenv
  ];

  # nh handles rebuilds and garbage collection. The path form keeps the
  # gitignored local.nix visible. See README
  programs.nh = {
    enable = true;
    flake = "path:/home/${username}/dotfiles";
  };
}

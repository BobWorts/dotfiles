{username, ...}: {
  imports = [
    ./cli.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./ghostty.nix
    ./neovim.nix
    ./zed.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./direnv.nix
    ./apps.nix
    ./media.nix
    ./discord.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Must match the system stateVersion in hosts/example/default.nix.
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}

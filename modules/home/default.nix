{...}: {
  imports = [
    ./cli.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./kitty.nix
    ./zed.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./direnv.nix
    ./apps.nix
    ./media.nix
    ./discord.nix
  ];

  # The HM release this config was first built with; independent of the system
  # stateVersion.
  home.stateVersion = "25.05";
}

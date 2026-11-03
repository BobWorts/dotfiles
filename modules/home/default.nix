{...}: {
  imports = [
    ./cli.nix
    ./fish.nix
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

  home.stateVersion = "26.05";
}

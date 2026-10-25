{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell/cachix";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      # Its home-manager module reuses HM's firefox module, so share ours.
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    niri,
    noctalia,
    stylix,
    ...
  } @ inputs: let
    hostSystem = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${hostSystem};

    # `local.nix` is gitignored, so a fresh clone or CI falls back to the example.
    local =
      if builtins.pathExists ./local.nix
      then import ./local.nix
      else
        builtins.trace
        "warning: local.nix not found, using local.example.nix. Build with path:<repo> to see a gitignored local.nix."
        (import ./local.example.nix);
    inherit (local) username;
  in {
    nixosConfigurations.${local.hostName} = nixpkgs.lib.nixosSystem {
      system = hostSystem;
      specialArgs = {inherit inputs username local;};
      modules = [
        niri.nixosModules.niri
        noctalia.nixosModules.default
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager

        ./hosts/example
        ./modules/nixos

        {
          nixpkgs.config.allowUnfree = true;
          # Vesktop builds Vencord with pnpm, which nixpkgs currently marks
          # insecure. It's a build-time tool only. Allow it by name so the rule
          # survives pnpm version bumps. (See modules/home/discord.nix.)
          nixpkgs.config.allowInsecurePredicate = pkg: nixpkgs.lib.getName pkg == "pnpm";
          nixpkgs.overlays = [
            niri.overlays.niri
            noctalia.overlays.default
          ];

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-bak";
          home-manager.extraSpecialArgs = {inherit inputs username local;};
          # niri-flake auto-imports its home modules (config + stylix) into
          # every user when home-manager runs as a NixOS module, so we only
          # add noctalia's here. Importing the niri ones again double-declares
          # `programs.niri.finalConfig`.
          home-manager.sharedModules = [
            noctalia.homeModules.default
          ];
          home-manager.users.${username} = import ./modules/home;
        }
      ];
    };

    # `nix fmt`
    formatter.x86_64-linux = pkgs.alejandra;

    # Tooling for hacking on this repo (`nix develop`).
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        statix
        deadnix
        nh
        nix-output-monitor
      ];
    };
  };
}

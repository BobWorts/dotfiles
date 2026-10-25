{
  description = "nnn-starter — an opinionated NixOS starter for the NNN stack (NixOS + Niri + Noctalia)";

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

    # Machine-local settings; `local.nix` is gitignored, so build through
    # `path:` (see README). A fresh clone / CI falls back to the example.
    local =
      if builtins.pathExists ./local.nix
      then import ./local.nix
      else
        builtins.trace
        "warning: local.nix not found — using local.example.nix placeholders. Build with `path:<repo>` so the gitignored file is visible."
        (import ./local.example.nix);
    inherit (local) username;

    # Linux systems for `nix fmt` / `nix develop`.
    devSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs devSystems;
    pkgsFor = system: nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.example = nixpkgs.lib.nixosSystem {
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
          # insecure. It's a build-time tool only; allow it by name so the rule
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
    formatter = forAllSystems (system: (pkgsFor system).alejandra);

    # `nix develop` — tooling for hacking on this repo.
    devShells = forAllSystems (system: {
      default = (pkgsFor system).mkShell {
        packages = with pkgsFor system; [
          alejandra
          statix
          deadnix
          nh
          nix-output-monitor
        ];
      };
    });
  };
}

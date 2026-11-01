{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake/3c93dc365616";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      # Reuse our home-manager input for the firefox module
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

    # Gitignored local settings. Fall back to the example on a fresh clone
    local =
      if builtins.pathExists ./local.nix
      then import ./local.nix
      else
        builtins.trace
        "warning: local.nix not found, using local.example.nix. Build with path:<repo> to see a gitignored local.nix."
        (import ./local.example.nix);
    inherit (local) username;

    # Real host and the eval-only twin used by CI
    mkNixosConfig = extraModules:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs username local;};
        modules =
          [
            niri.nixosModules.niri
            noctalia.nixosModules.default
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager

            ./hosts/${local.hostName}
            ./modules/nixos

            {
              nixpkgs.hostPlatform = hostSystem;
              nixpkgs.config.allowUnfree = true;
              # Vencord needs pnpm at build time and nixpkgs marks it insecure
              nixpkgs.config.allowInsecurePredicate = pkg: nixpkgs.lib.getName pkg == "pnpm";
              nixpkgs.overlays = [
                niri.overlays.niri
                noctalia.overlays.default
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = {inherit inputs username local;};
              # niri-flake imports its home modules per user. Importing them
              # again duplicates programs.niri.finalConfig
              home-manager.sharedModules = [
                noctalia.homeModules.default
              ];
              home-manager.users.${username} = import ./modules/home;
            }
          ]
          ++ extraModules;
      };
  in {
    nixosConfigurations.${local.hostName} = mkNixosConfig [];

    # Eval-only twin with a dummy root device. CI uses it while
    # hardware-configuration.nix is still a placeholder
    nixosConfigurations.ci = mkNixosConfig [
      {
        # Avoid a conflict with a generated hardware config
        fileSystems."/" = nixpkgs.lib.mkForce {
          device = "/dev/ci-dummy";
          fsType = "ext4";
        };
      }
    ];

    formatter.${hostSystem} = pkgs.alejandra;

    devShells.${hostSystem}.default = pkgs.mkShell {
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

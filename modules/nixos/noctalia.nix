{
  pkgs,
  inputs,
  ...
}: {
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    # Prebuilt cache from noctalia.cachix.org.
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}

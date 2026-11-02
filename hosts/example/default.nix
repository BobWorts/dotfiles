{local, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = local.hostName;

  system.stateVersion = "26.05";
}

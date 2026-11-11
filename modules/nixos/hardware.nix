{...}: {
  # Firmware updates from the LVFS catalog
  services.fwupd.enable = true;

  # Thunderbolt and USB4 authorization for docks and eGPUs
  services.hardware.bolt.enable = true;

  # Compressed RAM swap, faster than disk and less NVMe wear
  zramSwap.enable = true;

  # Fingerprint reader. Enroll with fprintd-enroll
  services.fprintd.enable = true;

  # Loader for prebuilt binaries like npm CLIs
  programs.nix-ld.enable = true;
}

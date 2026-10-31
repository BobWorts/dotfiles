{...}: {
  # Firmware updates via LVFS: `fwupdmgr refresh && fwupdmgr update`.
  services.fwupd.enable = true;

  # Thunderbolt / USB4 authorization (docks, eGPUs, TB SSDs).
  services.hardware.bolt.enable = true;

  # Compressed RAM swap. Faster than disk swap and saves NVMe wear.
  zramSwap.enable = true;

  # Fingerprint reader; enroll with `fprintd-enroll`.
  services.fprintd.enable = true;

  # Lets prebuilt glibc binaries (npm CLIs, vendor tools) find the loader.
  programs.nix-ld.enable = true;
}

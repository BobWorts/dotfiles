{pkgs, ...}: {
  # Intel laptop defaults (tested on a ThinkPad X1 Carbon Gen 13 / Lunar Lake).

  # Early microcode updates from the firmware. Off by default in nixpkgs;
  # fixes errata-class CPU bugs before the kernel has a chance to trip on them.
  hardware.cpu.intel.updateMicrocode = true;

  # GPU video acceleration. hardware.graphics itself is enabled by niri-flake.
  # These add the VA-API / QSV runtimes so browsers and players decode/encode
  # video on the iGPU instead of the CPU (the single biggest battery win on
  # Intel).
  #   intel-media-driver → the modern `iHD` VA-API driver (Gen8+ / Xe / Arc)
  #   vpl-gpu-rt         → oneVPL runtime for QuickSync (QSV) decode/encode
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    vpl-gpu-rt
  ];
  # Pin the VA-API driver so libva doesn't probe/guess.
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  # `vainfo` for inspecting the available decode/encode profiles.
  environment.systemPackages = [pkgs.libva-utils];

  # Intel thermal management daemon, keeps temps/throttling sane under load.
  # Standard on Intel laptops. Complements (does not conflict with) the
  # power-profiles-daemon used by the desktop.
  #   ignoreCpuidCheck: bypasses thermald's CPU/board blocklist. Lunar Lake is
  #   supported upstream, but the X1 Carbon's Lenovo dytc_lapmode entry makes
  #   thermald refuse to start otherwise.
  services.thermald.enable = true;
  services.thermald.ignoreCpuidCheck = true;

  # Firmware updates via LVFS: `fwupdmgr refresh && fwupdmgr update` pulls
  # BIOS/EC/Thunderbolt updates. ThinkPads are well supported upstream.
  services.fwupd.enable = true;

  # Thunderbolt / USB4 device authorization (docks, eGPUs, TB SSDs).
  # `boltctl` lists and authorizes devices.
  services.hardware.bolt.enable = true;

  # Compressed RAM swap. Faster than the disk swap partition and saves NVMe
  # wear. With 32 GB RAM the default (50% of RAM) is plenty of headroom.
  # (Too small to hibernate 32 GB. Hibernation needs a disk swap as big as RAM.)
  zramSwap.enable = true;

  # Fingerprint reader (enroll with `fprintd-enroll`). Wires fingerprint auth
  # into PAM for login/sudo via the libfprint stack.
  services.fprintd.enable = true;

  # Lets prebuilt glibc binaries (npm CLIs, random vendor tools, ...) find the
  # dynamic loader instead of failing on a missing /lib64/ld-linux.so.2.
  programs.nix-ld.enable = true;
}

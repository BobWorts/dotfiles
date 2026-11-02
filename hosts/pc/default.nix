{local, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # NVIDIA driver. open = true needs Turing or newer, use false on Maxwell and
  # Pascal cards
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };
  # The nvidia module installs nvidia-vaapi-driver itself
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };
  boot.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
  # hardware.nvidia.moduleParams already sets modeset and fbdev
  # https://niri-wm.github.io/niri/Nvidia.html#high-vram-usage-fix
  environment.etc = {
    "nvidia/nvidia-application-profiles-rc.d/niri.json" = {
      text = ''
        {
          "rules": [
            {
              "pattern": {
                "feature": "procname",
                "matches": "niri"
              },
              "profile": "Limit Free Buffer Pool On Wayland Compositors"
            }
          ],
          "profiles": [
            {
              "name": "Limit Free Buffer Pool On Wayland Compositors",
              "settings": [
                {
                  "key": "GLVidHeapReuseRatio",
                  "value": 0
                }
              ]
            }
          ]
        }
      '';
    };
  };

  networking.hostName = local.hostName;

  system.stateVersion = "26.05";
}

{local, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = local.hostName;

  # ⇩ Timezone and keyboard come from local.nix; the system locale is fixed here.
  time.timeZone = local.timeZone;
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = local.keyboardLayouts;
    variant = "";
    options = local.keyboardOptions;
  };
  console.keyMap = "us";

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "25.05";
}

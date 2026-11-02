{local, ...}: {
  time.timeZone = local.timeZone;

  # System locale, keyboards come from local.nix
  i18n.defaultLocale = local.locale or "en_US.UTF-8";

  services.xserver.xkb = {
    layout = local.keyboardLayouts;
    options = local.keyboardOptions;
  };

  # The tty reuses these layouts. niri reads them itself
  console.useXkbConfig = true;
}

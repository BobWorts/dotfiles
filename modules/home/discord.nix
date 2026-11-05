{...}: {
  # Vesktop because screen share with audio works on niri. Stylix ships the
  # theme, so no custom CSS
  programs.vesktop = {
    enable = true;
    mutableSettings = true;

    # Nix owns the package, so disable Vencord self-update
    vencord = {
      mutableSettings = true;
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
      };
    };
  };
}

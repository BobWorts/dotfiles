{
  pkgs,
  username,
  local,
  ...
}: {
  # Username/Description come from local.nix.
  users.users.${username} = {
    isNormalUser = true;
    description = local.fullName;
    extraGroups = [
      "wheel" # Sudo
      "networkmanager"
      "video"
      "audio"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # zsh must be enabled at the system level to be a valid login shell.
  programs.zsh.enable = true;

  # Disable sudo password for wheel group to speed up nixos-rebuild.
  security.sudo.wheelNeedsPassword = false;
}

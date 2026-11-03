{
  pkgs,
  username,
  local,
  ...
}: {
  users.users.${username} = {
    isNormalUser = true;
    description = local.fullName;
    extraGroups = [
      "wheel" # Sudo
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}

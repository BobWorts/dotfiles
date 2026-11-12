{
  pkgs,
  username,
  ...
}: {
  # No home-manager module, so steam is enabled here
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    protontricks.enable = true;
  };

  programs.gamemode.enable = true;
  users.users.${username}.extraGroups = ["gamemode"];

  environment.systemPackages = with pkgs; [
    mangohud
    gamescope
  ];
}

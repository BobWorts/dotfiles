{
  pkgs,
  username,
  ...
}: {
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

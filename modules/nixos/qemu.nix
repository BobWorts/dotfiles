{
  lib,
  pkgs,
  username,
  local,
  ...
}: {
  config = lib.mkIf (local.useQEMU or false) {
    virtualisation.libvirtd = {
      enable = true;
      # Guest RAM is not dumped on host shutdown
      onShutdown = "shutdown";
      qemu = {
        package = pkgs.qemu_kvm; # Host architecture only, saves space
        swtpm.enable = true; # Software TPM for Windows 11 guests
      };
    };

    programs.virt-manager.enable = true;

    # Manage VMs without sudo
    users.users.${username}.extraGroups = ["libvirtd"];
  };
}

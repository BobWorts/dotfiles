{
  lib,
  pkgs,
  username,
  local,
  ...
}: {
  # Enabled from local.nix: `useQEMU = true;`
  config = lib.mkIf (local.useQEMU or false) {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # Full-featured qemu instead of the minimal build
        swtpm.enable = true; # Software TPM, needed for Windows 11 guests
      };
    };

    programs.virt-manager.enable = true;

    # Manage VMs without sudo (root-equivalent).
    users.users.${username}.extraGroups = ["libvirtd"];
  };
}

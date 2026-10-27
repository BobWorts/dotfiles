{...}: {
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Local DNS stub; NetworkManager hands it per-connection DNS automatically.
  services.resolved.enable = true;

  # mDNS for `.local` names (NAS, printers, ssh). The module opens UDP 5353 in
  # the firewall itself.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}

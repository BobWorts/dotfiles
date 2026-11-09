{...}: {
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # Local DNS stub, NetworkManager passes per connection DNS
  services.resolved.enable = true;
  # Encrypt DNS when the server supports it
  services.resolved.settings.Resolve.DNSOverTLS = "opportunistic";

  # mDNS for .local names. The module opens UDP 5353 itself
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}

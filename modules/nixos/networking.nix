{...}: {
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPorts = [];
  };

  # NTP: a skewed clock causes bogus TLS certificate errors.
  services.timesyncd.enable = true;

  # Faster name resolution / mDNS for `.local` hosts.
  services.resolved.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}

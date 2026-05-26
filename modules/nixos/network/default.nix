{ ... }:
{
  # Enable networking
  networking = {
    # Xinux modules has this list already
    # nameservers = [
    #   # AdGuard DNS
    #   "94.140.14.14"
    #   "94.140.15.15"
    #   "2a10:50c0::ad1:ff"
    #   "2a10:50c0::ad2:ff"
    #   # NextDNS
    #   "45.90.28.148"
    #   "45.90.30.148"
    #   "2a07:a8c0::35:958c"
    #   "2a07:a8c1::35:958c"
    # ];
    networkmanager.enable = true;
    # hostName = "matax"; # Define your hostname.

    firewall = {
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
        80
        443
      ];
    };
  };
}

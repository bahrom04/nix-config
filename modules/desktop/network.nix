{...}: {
  config = {
    # Enable networking
    networking = {
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
  };
}

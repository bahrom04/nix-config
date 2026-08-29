{
  services = {
    pcscd.enable = true;
    opensnitch.enable = false;

    # iphone usb connection
    usbmuxd.enable = true;
    
    openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # (not recommended)
        PasswordAuthentication = true;
      };
    };

    zerotierone = {
      enable = false;
      joinNetworks = [
        "743993800f4720b2"
      ];
    };
  };
}

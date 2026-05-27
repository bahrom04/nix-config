{
  services = {
    pcscd.enable = true;
    opensnitch.enable = false;

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

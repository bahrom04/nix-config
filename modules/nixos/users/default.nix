{
  pkgs,
  ...
}:
{
  home-manager.backupFileExtension = "hbak";

  users.users = {
    bahrom = {
      hashedPassword = "$2b$05$QgiAihjGOtxfGZ06pfm2u.dMR6522sT2Pmy4mt//Rf2x5YonDcD.2";
      isNormalUser = true;
      description = "Bahrom";
      shell = pkgs.zsh;

      extraGroups = [
        "networkmanager"
        "wheel"
        "media"
        "admins"
        "input"
        "libvirtd"
        "vboxusers"
        "docker"
        "podman"
      ];

      openssh.authorizedKeys.keys = [
        # dll
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+EVAeaZpe98gggH8fPQ4bKEgw2FbTqYzngTRSpSbp magdiyevbahrom04@gmail.com"
        # # mtx
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEJjeEUMVe4fyRXVGbG4UvQiSACjPv/AEdyytIazfgT magdiyevbahrom@gmail.com"
        # # add more
      ];
    };
    test = {
      hashedPassword = "$2b$05$QgiAihjGOtxfGZ06pfm2u.dMR6522sT2Pmy4mt//Rf2x5YonDcD.2";
      isNormalUser = true;
      description = "Bahrom uchun test user";
      shell = pkgs.zsh;

      extraGroups = [
        "networkmanager"
        "wheel"
        "media"
        "admins"
        "input"
        "libvirtd"
        "vboxusers"
        "docker"
        "podman"
      ];
    };
  };
}

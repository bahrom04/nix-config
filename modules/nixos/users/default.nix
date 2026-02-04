{
  pkgs,
  inputs,
  ...
}: let
  hashedPassword = "$2b$05$QgiAihjGOtxfGZ06pfm2u.dMR6522sT2Pmy4mt//Rf2x5YonDcD.2";
in {
  config = {
    xinux-org.users.bahrom = {
      home.config = {};
    };
    
    users.users = {
      bahrom = {
        inherit hashedPassword;
        isNormalUser = true;
        description = "Bahrom";
        shell = pkgs.zsh;

        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "vboxusers"
          "media"
          "admins"
          "libvirtd"
          "input"
        ];

        openssh.authorizedKeys.keys = [
          # dll
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+EVAeaZpe98gggH8fPQ4bKEgw2FbTqYzngTRSpSbp magdiyevbahrom04@gmail.com"
          # mtx
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFEJjeEUMVe4fyRXVGbG4UvQiSACjPv/AEdyytIazfgT magdiyevbahrom@gmail.com"
          # add more
        ];
      };
    };

    home-manager = {
      backupFileExtension = "hbak";
      extraSpecialArgs = {
        inherit inputs;
      };
      users = {
        # Import your home-manager configuration
        bahrom = import ../../hosts/matax/home.nix;
      };
    };
  };
}

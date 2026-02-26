{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # useful when debugging xeonitte (xinux installer)
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';

  services.relago = {
    enable = false;
    # user = users.users.lambdajon;
  };

  networking.hostName = "matax";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/modules/nixos/apps/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    flakearg = "matax";
  };

  services = {
    samba = {
      enable = true;
      package = pkgs.samba4Full;
      openFirewall = true;

      settings = {
        global = {
          "server smb encrypt" = "required";
          "server min protocol" = "SMB3_00";
          "workgroup" = "WORKGROUP";
          "security" = "user";
        };

        testshare = {
          "path" = "/home/bahrom/Public";
          "writable" = "yes";
          "comment" = "Hello World!";
          "browseable" = "yes";
        };
        # fayllar = {
        #   "path" = "/media/fayllar";
        #   "writable" = "yes";
        #   "comment" = "Hello World!";
        #   "browseable" = "yes";
        # };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
    avahi = {
      enable = true;
      publish.enable = true;
      publish.userServices = true;
      openFirewall = true;
    };
  };

  # remove all gnome utility apps
  # services.gnome.core-utilities.enable = false;

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}

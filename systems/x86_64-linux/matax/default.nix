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

  # Relago service
  services.relago = {
    enable = true;
    nix-config = "/home/bahrom/workplace/bahrom04/nix-config/";
  };

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "uz_UZ.UTF-8";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  # useful when debugging xeonitte (xinux installer)
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel"))
        return polkit.Result.YES;
    });
  '';

  # services.relago = {
  #   enable = false;
  #   # user = users.users.lambdajon;
  # };

  networking.hostName = "matax";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/matax/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    hostname = "matax";
  };

  services = {
    # NVIDIA driver support
    xserver.videoDrivers = [ "nvidia" ];

    samba = {
      enable = true;
      package = pkgs.samba;
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
  environment.systemPackages = with pkgs; [
    imgbrd-grabber
    calamares-nixos-extensions
    calamares-nixos
    # calamares
    gnomeExtensions.pop-shell
    aurea
    gnome-firmware
    footage
  ];

  # # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users = {
  #   "@USERNAME@" = {
  #     isNormalUser = true;
  #     description = "@FULLNAME@";
  #     extraGroups = [
  #       "wheel"
  #       "networkmanager"
  #       "dialout"
  #     ];
  #   };
  # };
  # users.users = "";
}

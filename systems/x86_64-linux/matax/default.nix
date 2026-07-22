{
  lib,
  pkgs,
  inputs,
  ...
}:
let
  relago = inputs.relago.packages."${pkgs.stdenv.hostPlatform.system}".default;
in
{
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  services.relago = {
    enable = true;
    # nix-config = "/home/bahrom/workplace/bahrom04/nix-config/";
  };

  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/settings-daemon/plugins/media-keys" = {
              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
              ];
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
              name = "open-terminal";
              binding = "<Shift><Alt>t";
              command = "kgx";
            };
            "org/gnome/desktop/wm/preferences" = {
              resize-with-right-button = true;
            };
          };
        }
      ];
    };
  };

  console.keyMap = "us";
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

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/matax/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    hostname = "matax";
  };

  networking.hostName = "matax";
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = "25.11";
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    imgbrd-grabber
    calamares-nixos-extensions
    calamares-nixos
    # calamares
    gnomeExtensions.pop-shell
    aurea
    gnome-firmware
    footage
    bazaar
    cambalache
    # relago
  ];

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
  #
  #
  #
  # # services.samba = {
  #   enable = true;
  #   openFirewall = true;
  #   settings = {
  #     global = {
  #       "workgroup" = "WORKGROUP";
  #       "server string" = "smbnix";
  #       "netbios name" = "smbnix";
  #       "security" = "user";
  #       #"use sendfile" = "yes";
  #       #"max protocol" = "smb2";
  #       # note: localhost is the ipv6 localhost ::1
  #       "hosts allow" = "192.168.0. 127.0.0.1 localhost";
  #       "hosts deny" = "0.0.0.0/0";
  #       "guest account" = "nobody";
  #       "map to guest" = "bad user";
  #     };
  #     "public" = {
  #       "path" = "/home/bahrom/Public";
  #       "browseable" = "yes";
  #       "read only" = "no";
  #       "guest ok" = "yes";
  #       "create mask" = "0644";
  #       "directory mask" = "0755";
  #       "force user" = "username";
  #       "force group" = "groupname";
  #     };
  #     # "private" = {
  #     #   "path" = "/mnt/Shares/Private";
  #     #   "browseable" = "yes";
  #     #   "read only" = "no";
  #     #   "guest ok" = "no";
  #     #   "create mask" = "0644";
  #     #   "directory mask" = "0755";
  #     #   "force user" = "username";
  #     #   "force group" = "groupname";
  #     # };
  #   };
  # };

  # services.samba-wsdd = {
  #   enable = true;
  #   openFirewall = true;
  # };

  # services.avahi = {
  #   publish.enable = true;
  #   publish.userServices = true;
  #   # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
  #   nssmdns4 = true;
  #   # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
  #   enable = true;
  #   openFirewall = true;
  # };
  #
  #
  # services = {
  #   # NVIDIA driver support
  #   xserver.videoDrivers = [ "nvidia" ];

  #   samba = {
  #     enable = true;
  #     package = pkgs.samba;
  #     openFirewall = true;

  #     settings = {
  #       global = {
  #         "server smb encrypt" = "required";
  #         "server min protocol" = "SMB3_00";
  #         "workgroup" = "WORKGROUP";
  #         "security" = "user";
  #       };

  #       testshare = {
  #         "path" = "/home/bahrom/Public";
  #         "writable" = "yes";
  #         "comment" = "Hello World!";
  #         "browseable" = "yes";
  #       };
  #       # fayllar = {
  #       #   "path" = "/media/fayllar";
  #       #   "writable" = "yes";
  #       #   "comment" = "Hello World!";
  #       #   "browseable" = "yes";
  #       # };
  #     };
  #   };
  #   samba-wsdd = {
  #     enable = true;
  #     openFirewall = true;
  #   };
  #   avahi = {
  #     enable = true;
  #     publish.enable = true;
  #     publish.userServices = true;
  #     openFirewall = true;
  #   };
  # };
}

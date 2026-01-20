{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # configs for module manager
    ./modules.nix
    # options for module manager
    ../../nixos/xinux/default.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-data.nixosModules.nix-data
    inputs.self.homeModules.nixpkgs
    inputs.self.homeModules.desktop
    inputs.self.homeModules.keyboard
    inputs.self.homeModules.users.bahrom04
  ];

  networking.hostName = "matax";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/hosts/matax/configuration.nix";
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

  #auto_profile_tg = {
  #  enable = false;
  #  api_id = config.sops.secrets.api_id.path;
  #  api_hash = config.sops.secrets.api_hash.path;
  #  phone_number = config.sops.secrets.phone_number.path;
  #  first_name = config.sops.secrets.first_name.path;
  #  lat = config.sops.secrets.lat.path;
  #  lon = config.sops.secrets.lon.path;
  #  timezone = config.sops.secrets.timezone.path;
  #  city = config.sops.secrets.city.path;
  #  weather_api_key = config.sops.secrets.weather_api_key.path;
  #};

  # remove all gnome utility apps
  # services.gnome.core-utilities.enable = false;

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
  environment.systemPackages = [
    pkgs.sqlitebrowser
    pkgs.boltbrowser
    pkgs.kstars
    pkgs.gnome-solanum
    pkgs.nextcloud-client
    pkgs.icon-library
    pkgs.calamares-nixos
    pkgs.gnome-podcasts
    pkgs.cambalache
    pkgs.adwsteamgtk
    pkgs.bustle
    pkgs.firefox
    pkgs.gradia
  ];
}

{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
  gnomeApps = outputs.homeModules.gnome {inherit pkgs;};
in {
  imports = [
    ./hardware-configuration.nix
    # Home manager darwin modules
    inputs.home-manager.nixosModules.home-manager

    outputs.homeModules.nixpkgs
    outputs.homeModules.desktop
  ];

  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
      MIIEBDCCAuygAwIBAgIRAID5hYfq5Qz6JbWvqXsy8i8wDQYJKoZIhvcNAQELBQAw
      gYwxDzANBgNVBAMMBkUtSU1aTzFsMGoGA1UECgxj0JPQo9CfINCd0LDRg9GH0L3Q
      vi3QuNC90YTQvtGA0LzQsNGG0LjQvtC90L3Ri9C5INGG0LXQvdGC0YAgwqvQr9Cd
      0JPQmCDQotCV0KXQndCe0JvQntCT0JjQr9Cb0JDQoMK7MQswCQYDVQQGEwJVWjAe
      Fw0yMjA5MjIxMDE2MzhaFw00MjA5MjIxMDE2MzhaMIGMMQ8wDQYDVQQDDAZFLUlN
      Wk8xbDBqBgNVBAoMY9CT0KPQnyDQndCw0YPRh9C90L4t0LjQvdGE0L7RgNC80LDR
      htC40L7QvdC90YvQuSDRhtC10L3RgtGAIMKr0K/QndCT0Jgg0KLQldCl0J3QntCb
      0J7Qk9CY0K/Qm9CQ0KDCuzELMAkGA1UEBhMCVVowggEiMA0GCSqGSIb3DQEBAQUA
      A4IBDwAwggEKAoIBAQCUlGz+QoFa/j72DLY2DoBr1UOa0gun2kxfBISWYSS3djqQ
      5HuHEvFfiJ4BMX6agCqxmM+tOcL7i9BCDBOE8TwxSgJY+RBnWbQiET2qdnI1IgVc
      Kb1QXQCmqaj8dvSlIOb7CMHBVmjuWXmPHWA9KIecE/mpZyb5UHmtnz3zDfpjiZqj
      X0fJhn0VaP8P92ykaFkmMAiUT7kfpA8tFxBBOfX8Gu9ANVB9GMAVPMktk0kMsZZc
      xZY+n4FEJ33xyJ3Uv8NwMEpDEWIHPopqrpIHZ1oro/j+Csi/nV4u3ZMifwOuyLYO
      S5GjGaOUPeY//pIGOMw6JxdWDVyB20nd82gpnrljAgMBAAGjXzBdMB0GA1UdDgQW
      BBRzzguLjqvNCPqq+iX47UYMAxP41TAQBgNVHRMECTAHAQH/AgIA/zALBgNVHQ8E
      BAMCAaYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMBMA0GCSqGSIb3DQEB
      CwUAA4IBAQA8xZlYde8XcJPMhNp+SI1DEu7QITkEVwbXIWe702b+/LnxBTAw6xou
      Q2r1TY9Gqyiv3zx3kmoY+v67+6IH9GzsFomfi6e+txAhdePIpIetWM84mqAwP0Ej
      d9ynUZi1q/PGdzvaZabL9wpzb6ovvMKuJJ+4oLokq3g9kw2bvxt61ZhkQ0Nkr04W
      NqPKmFpMqz5TMAQ1zRW3LSNMjc1TJCVayXouICjQ2am9nPGUvWQVSwQIHCl10E/B
      GIFRvadXV9+hDlDM7qYund1k+5cWrStoRnnpHAdQK//KePfyiHRZXVabmQ8CyPEb
      K1r+sxWbiCvrXMN9AqKdHqZSZ22Od9xZ
      -----END CERTIFICATE-----
    ''
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "uz_UZ.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment = {
    variables = {
      EDITOR = "vim";
      SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs;
      [
        nixfmt-rfc-style
        neovim
        vim
        fastfetch
        age
        sops
        rng-tools
        pinentry
        haveged

        # Services
        redis
      ]
      ++ gnomeApps;
  };

  services.e-imzo.enable = true;

  #system.primaryUser = "bahrom";
  programs.zsh.enable = true;
  users.users = {
    bahrom = {
      name = "bahrom";
      home = "/home/bahrom";
      isNormalUser = true;
      description = "bahrom's profile";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.zsh;
      packages = with pkgs; [
        thunderbird
        firefox
        telegram-desktop
        google-chrome
      ];
    };
    adam = {
      name = "adam";
      home = "/home/adam";
      isNormalUser = true;
      description = "islom";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        telegram-desktop
        google-chrome
      ];
    };
  };

  home-manager = {
    # useGlobalPkgs = true;
    # useUserPackages = true;
    backupFileExtension = "hbak";
    users.bahrom = import ../../home.nix;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  programs.mtr.enable = true;
  
  # Replace commant not found with nix-index
  # programs.nix-index = {
  #   enable = true;
  # };

  # Networking DNS & Interfaces
  #networking = {
  #  computerName = "air"; # Define your computer name.
  #  localHostName = "air"; # Define your local host name.
  #};

  #services.auto_profile_tg = {
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

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.05";
}

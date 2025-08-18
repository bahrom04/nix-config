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
  };

  # NVIDIA driver support
  services.xserver.videoDrivers = ["nvidia"];
  
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
        element-desktop
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
      extraGroups = ["networkmanager" "wheel" "vboxusers" "libvirtd"];
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

  networking.hostName = "bahrom"; # Define your hostname.

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.05";
}

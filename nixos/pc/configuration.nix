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
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "bahrom"; # Define your hostname.
  };

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "uz_UZ.UTF-8";

  # Garbage collector.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 10d";
  };

  # Enable CUPS to print documents.
  services = {
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # NVIDIA driver support
    xserver.videoDrivers = ["nvidia"];
    e-imzo.enable = true;
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
  };

  # Enable sound with pipewire.
  security = {
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = ["bahrom"];
        commands = [
          {
            command = "/run/wrappers/bin/sudo nixos-rebuild switch --flake . --show-trace";
            options = ["NOPASSWD"];
          }
          {
            command = "/run/wrappers/bin/sudo nixos-rebuild switch --flake .";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
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
        element-desktop
        telegram-desktop
        google-chrome
        # Services
        redis
      ]
      ++ gnomeApps;
  };

  users.users = {
    bahrom = {
      name = "bahrom";
      home = "/home/bahrom";
      isNormalUser = true;
      description = "bahrom's profile";
      extraGroups = ["networkmanager" "wheel" "vboxusers" "libvirtd"];
      shell = pkgs.zsh;
    };
    adam = {
      name = "adam";
      home = "/home/adam";
      isNormalUser = true;
      description = "islom";
      extraGroups = ["networkmanager" "wheel"];
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

  # does nothing. can not scale my resolution to 150%. Only 200% and 100%
  # home-manager.users.gdm = {lib, ...}: {
  #   dconf.settings = {
  #     "org/gnome/desktop/interface" = {
  #       # text-scaling-factor = 1.5; # 150% text scaling
  #       scaling-factor = 1.5;
  #     };
  #     "org/gnome/mutter" = {
  #       experimental-features = ["scale-monitor-framebuffer"]; # enables fractional scaling
  #     };
  #   };
  #   home.stateVersion = "25.05";
  # };

  programs = {
    zsh.enable = true;
    mtr.enable = true;
  };

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.05";
}

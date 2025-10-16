{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
  gnomeApps = inputs.self.homeModules.gnome_apps {inherit pkgs;};
  nix-software-center = inputs.nix-software-center.packages."${pkgs.system}".nix-software-center;
  xinux-module-manager = inputs.xinux-module-manager.packages."${pkgs.system}".xinux-module-manager;
  nixos-conf-editor = inputs.nixos-conf-editor.packages."${pkgs.system}".nixos-conf-editor;
  hunspell-uz = inputs.hunspell-uz.packages."${pkgs.system}".default;
in {
  imports = [
    ./hardware-configuration.nix

    # Home manager darwin modules
    inputs.home-manager.nixosModules.home-manager
    inputs.self.homeModules.nixpkgs
    inputs.self.homeModules.desktop
    inputs.self.homeModules.users.bahrom04
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "matax"; # Define your hostname.
  };

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "uz_UZ.UTF-8";
  i18n.supportedLocales = ["all"];

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
    # sudo.extraRules = [
    #   {
    #     users = ["bahrom"];
    #     commands = [
    #       {
    #         command = "/run/wrappers/bin/sudo nixos-rebuild switch --flake . --show-trace";
    #         options = ["NOPASSWD"];
    #       }
    #       {
    #         command = "/run/wrappers/bin/sudo nixos-rebuild switch --flake .";
    #         options = ["NOPASSWD"];
    #       }
    #     ];
    #   }
    # ];
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
        hunspell
        hunspell-uz # todo: add pkgs.hunspell.uz-UZ
        hunspellDicts.uk_UA
        rng-tools
        pinentry
        haveged
        element-desktop
        telegram-desktop
        xorg.setxkbmap
        xorg.xkbcomp
        # Browsers
        google-chrome
        chromium
        android-studio
        # Services
        redis
        # Xinux
        nix-software-center
        xinux-module-manager
        nixos-conf-editor
      ]
      ++ gnomeApps;
  };

  environment.variables = {
    DICPATH = "/run/current-system/sw/share/hunspell/";
    DICTIONARY_PATH = "/run/current-system/sw/share/hunspell";
  };
  # android_sdk.accept_license = true;
  programs = {
    zsh.enable = true;
    mtr.enable = true;
    steam.enable = true;
    # Install firefox.
    firefox = {
      enable = true;
      preferences = {
        "spellchecker.dictionary_path" = "/run/current-system/sw/share/hunspell/";
        "layout.spellcheckDefault" = 2;
      };
      languagePacks = ["en-US" "uz"];
    };
  };
  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.05";
}

{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";

  modules = import ../../modules;
in {
  imports = [
    ./hardware-configuration.nix
    # Custom modules
    #inputs.auto_profile_tg.darwinModules.default
    # Home manager darwin modules
    inputs.home-manager.nixosModules.home-manager
    # Configuration modules
    #modules.sops
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

  # Enable the X11 windowing system.
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        # Change default background
        [org.gnome.desktop.background]
        picture-uri='file://${pkgs.nixos-artwork.wallpapers.nineish.gnomeFilePath}'

        # Background for dark theme
        [org.gnome.desktop.background]
        picture-uri-dark='file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}'

        # Prefer dark theme
        [org.gnome.desktop.interface]
        color-scheme='prefer-dark'

        # Favorite apps in gnome-shell
        [org.gnome.shell]
        favorite-apps=['org.gnome.Nautilus.desktop', 'org.gnome.Epiphany.desktop', 'org.gnome.SystemMonitor.desktop', 'org.gnome.Console.desktop', 'org.gnome.gitg.desktop', 'org.gnome.Builder.desktop', 'org.gnome.Polari.desktop']

        # Enable user extensions
        [org.gnome.shell]
        disable-user-extensions=false

        # List of enabled extensions
        [org.gnome.shell]
        enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com', 'light-style@gnome-shell-extensions.gcampax.github.com', 'system-monitor@gnome-shell-extensions.gcampax.github.com']

        # Workspace should grow dynamically
        [org.gnome.mutter]
        dynamic-workspaces=true

        # Edge Tiling with mouse
        [org.gnome.mutter]
        edge-tiling=true

        # Use default color scheme
        [org.gnome.desktop.interface]
        color-scheme='default'

        # Automatic timezone
        [org.gnome.desktop.datetime]
        automatic-timezone=true

        # Never show the notice on tweak
        [org.gnome.tweaks]
        show-extensions-notice=false

        # Show all three button layers
        [org.gnome.desktop.wm.preferences]
        button-layout='appmenu:minimize,maximize,close'

        # Dash to dock for multiple monitors
        [org.gnome.shell.extensions.dash-to-dock]
        multi-monitor=true

        # Custom theme on Dash to dock
        [org.gnome.shell.extensions.dash-to-dock]
        apply-custom-theme=true

        # Don't hibernate on delay
        [org.gnome.settings-daemon.plugins.power]
        sleep-inactive-ac-type='nothing'

        # Don't sleep, don't sleep!
        [org.gnome.desktop.session]
        idle-delay=0
      '';
      extraGSettingsOverridePackages = [
        pkgs.gsettings-desktop-schemas
        pkgs.gnome-shell
      ];
    };
  };
  services.flatpak.enable = true;

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

  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings.experimental-features = "nix-command flakes";
  };

  environment = {
    variables = {
      EDITOR = "vim";
      SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs; [
      flatpak-builder
      gnome-builder
      nixfmt-rfc-style
      neovim
      vim
      fastfetch
      redis
      age
      sops
      rng-tools
      pinentry
      haveged
      fractal
      gnome-extension-manager
      gnomeExtensions.dash-to-dock
      gnomeExtensions.applications-menu
      e-imzo
    ];
  };

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Disable if you don't want linux thingies on mac
      allowUnsupportedSystem = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # Let the system use fucked up programs
      allowBroken = true;
    };
  };

  services.redis.enable = true;

  #system.primaryUser = "bahrom";

  users.users = {
    bahrom = {
      name = "bahrom";
      home = "/home/bahrom";
      isNormalUser = true;
      description = "bahrom's profile";
      extraGroups = ["networkmanager" "wheel"];
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

  # Automatic flake devShell loading
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = false;
    nix-direnv.enable = true;
  };

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

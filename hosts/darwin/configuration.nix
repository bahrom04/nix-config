{
  lib,
  inputs,
  pkgs,
  ...
}: let
  # age_keys = "${config.users.users.bahrom04.home}/.config/sops/age/keys.txt";
in {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.self.homeModules.nixpkgs
    # Custom modules
    # inputs.auto_profile_tg.darwinModules.default
  ];

  environment = {
    variables = {
      EDITOR = "vim";
      # SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs; [
      nixfmt-rfc-style
      neovim
      fastfetch
      redis
      age
      sops
    ];
  };

  services.redis.enable = true;

  # MacOs Dock setttings
  system.defaults.dock = {
    autohide = false;
    largesize = 16;
    mineffect = "scale";
    minimize-to-application = true;
    mru-spaces = true;
    orientation = "bottom";
    show-recents = false;
    show-process-indicators = true;
    tilesize = 50;
  };

  system.primaryUser = "bahrom04";

  users.users = {
    bahrom04 = {
      name = "bahrom04";
      home = "/Users/bahrom04";
    };
  };

  home-manager = {
    # useGlobalPkgs = true;
    # useUserPackages = true;
    backupFileExtension = "hbak";
    users.bahrom04 = import ./home.nix;
    extraSpecialArgs = {
      inherit inputs;
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
  programs.nix-index = {
    enable = true;
  };

  # Networking DNS & Interfaces
  networking = {
    computerName = "air"; # Define your computer name.
    localHostName = "air"; # Define your local host name.
  };

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
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}

{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    neovim
    fastfetch
    redis
  ];

  services.redis.enable = true;

  programs.fish.enable = true;

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

  users.users.bahrom04 = {
    name = "bahrom04";
    home = "/Users/bahrom04";
    shell = pkgs.fish;
    uid = 501;
  };

  nixpkgs.config.allowUnfree = true;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager = {
    users.bahrom04 = import ../home.nix;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  services.auto-profile-tg = {
    enable = true;
    app-id = "";
    api-hash = "";
    phone-number = "+";
    first-name = "Bahrom";
    lat = "41.2995";
    lon = "69.2401";
    timezone = "Asia/Tashkent";
    weather-api-key = "";
  };

  system.stateVersion = 5;
}

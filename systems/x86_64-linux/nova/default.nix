{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./modules.nix
    ./hardware-configuration.nix
  ];
  
  # useful when debugging xeonitte (xinux installer)
  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (subject.isInGroup("wheel"))
  #       return polkit.Result.YES;
  #   });
  # '';

  services = {
    scx.enable = true;
    system76-scheduler.enable = false;
    logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
    thermald.enable = true;
    # powerManagement.powertop.enable = true;
    # powerManagement.enable = false;
    power-profiles-daemon.enable = false;
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          platform_profile = "performance";
          turbo = "auto";
          platform_profile_strict = true;
          # enable_thresholds = true;
          # start_threshold = 75;
          # stop_threshold = 80;
        };
        battery = {
          governor = "powersave";
          energy_performance_preference = "balance_performance";
          platform_profile = "balanced";
          turbo = "auto";
          platform_profile_strict = true;
        };
      };
    };
  };

  # https://nixos.wiki/wiki/Hibernation
  systemd.sleep.settings.Sleep = {
    # 30 minute
    HibernateDelaySec = "1800";
  };

  console.keyMap = "us";
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "uz_UZ.UTF-8";
  networking.hostName = "nova";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/Projects/bahrom04/nix-config/systems/x86_64-linux/nova/default.nix";
    flake = "/home/bahrom/Projects/bahrom04/nix-config/flake.nix";
    hostname = "nova";
  };

  environment.systemPackages = with pkgs; [
    firefox
    bazaar
    phoronix-test-suite
    distroshelf
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "26.11";
}

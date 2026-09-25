{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./modules.nix
    ./hardware-configuration.nix
  ]
  ++ [ inputs.nixos-hardware.nixosModules.common-pc-laptop ];

  # useful when debugging xeonitte (xinux installer)
  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (subject.isInGroup("wheel"))
  #       return polkit.Result.YES;
  #   });
  # '';

  networking.useDHCP = false;

  services.intel-lpmd = {
    enable = true;
    config.meteorLake = true;
    mode = "AUTO";
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  powerManagement.powertop.enable = true;
  services = {
    logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
    scx.enable = true;
    system76-scheduler.enable = false;
    power-profiles-daemon.enable = false;
    thermald.enable = true;
    auto-cpufreq = {
      enable = false;
      settings = {
        charger = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";

        };
        battery = {
          governor = "powersave";
          turbo = "auto";
          energy_performance_preference = "balance_power";
        };
      };
    };
  };

  # https://nixos.wiki/wiki/Hibernation
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "1800"; # 30 minute
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

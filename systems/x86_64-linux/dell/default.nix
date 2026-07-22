{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./modules.nix
    ./hardware-configuration.nix
  ];

  # chaotic.nyx.cache.enable = true;

  # useful when debugging xeonitte (xinux installer)
  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (subject.isInGroup("wheel"))
  #       return polkit.Result.YES;
  #   });
  # '';
  programs = {
    dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/settings-daemon/plugins/media-keys" = {
              custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
              ];

            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
              name = "open-terminal";
              binding = "<Ctrl><Alt>t";
              command = "kgx";
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
              name = "open-nautilus";
              binding = "<Super>e";
              command = "nautilus";
            };
            "org/gnome/desktop/wm/preferences" = {
              resize-with-right-button = true;
            };
          };
        }
      ];
    };
  };

  services = {
    system76-scheduler = {
      enable = false;
    };
    logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
    thermald.enable = true;
  };

  # https://nixos.wiki/wiki/Hibernation
  systemd.sleep.settings.Sleep = {
    # 30 minute
    HibernateDelaySec = "1800";
  };

  console.keyMap = "us";
  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "uz_UZ.UTF-8";
  networking.hostName = "dell";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/dell/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    hostname = "dell";
  };

  environment.systemPackages = with pkgs; [
    bazaar
    phoronix-test-suite
    distroshelf
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}

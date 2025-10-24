{pkgs, ...}: {
  services.flatpak.enable = true;

  console.keyMap = "us";
  # Enable the X11 windowing system.
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      extraLayouts.uz = {
        description = "Uzbek (Oʻzbekiston)";
        languages = ["eng" "uzb"];
        symbolsFile = "${pkgs.fetchFromGitHub {
          owner = "bahrom04";
          repo = "uzbek-latin-keyboard";
          rev = "main";
          hash = "sha256-29UHkTc+k+IXt491zKows2Y4g1Ba6XdjlO2wnTMJFQM=";
        }}/uz";
        # symbolsFile = ../uz;
      };
      layout = "uz,us";
      variant = "latin";

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
        # Prefer dark theme
        [org.gnome.desktop.interface]
        color-scheme='prefer-dark'

        [org.gnome.desktop.interface]
        icon-theme='Papirus-Dark'

        # Favorite apps in gnome-shell
        [org.gnome.shell]
        favorite-apps=['org.gnome.Nautilus.desktop', 'org.gnome.SystemMonitor.desktop', 'org.gnome.Console.desktop', 'org.gnome.gitg.desktop']

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

  # Virtualization (for GNOME Boxes)
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            })
          .fd
          ];
        };
      };
    };
  };
}

{pkgs, ...}: {
  imports = [
    ./utils.nix
  ];

  console.keyMap = "us";
  # Enable sound with pipewire.
  security = {
    sudo-rs.enable = true;
    rtkit.enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services = {
    flatpak.enable = true;

    displayManager = {
      gdm = {
        wayland = true;
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
        favorite-apps=['org.gnome.Nautilus.desktop','org.gnome.SystemMonitor.desktop','org.gnome.Console.desktop','org.gnome.gitg.desktop','org.xinux.NixSoftwareCenter.desktop','org.xinux.NixosConfEditor.desktop','org.xinux.XinuxModuleManager.desktop','uz.xinux.EIMZOManager.desktop']

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

        [org.gnome.shell.extensions.dash-to-dock]
        click-action='minimize'

        # Don't hibernate on delay
        [org.gnome.settings-daemon.plugins.power]
        sleep-inactive-ac-type='nothing'

        # Don't sleep, don't sleep!
        [org.gnome.desktop.session]
        idle-delay=0

        [org.gnome.settings-daemon.plugins.media-keys]
        custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']
        screensaver=['<Control><Alt>l']

        [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
        binding='<Shift><Control>t'
        command='kgx --tab'
        name='open terminal'
      '';
      extraGSettingsOverridePackages = [
        pkgs.gsettings-desktop-schemas
        pkgs.gnome-shell
      ];
    };
    # Enable CUPS to print documents.
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
    pcscd.enable = true;
  };

  # Garbage collector.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 10d";
  };

  # Virtualization (for GNOME Boxes)
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    atop.enable = true;
    zsh.enable = true;
    mtr.enable = true;
    steam.enable = true;
  };
}

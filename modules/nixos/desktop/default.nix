{ pkgs, ... }:
{
  console.keyMap = "us";

  security = {
    sudo-rs.enable = true;
    rtkit.enable = true;
  };

  # Enable the GNOME Desktop Environment.
  services = {
    displayManager = {
      gdm = {
        wayland = true;
        enable = true;
        autoSuspend = false;
      };
    };
    desktopManager.gnome = {
      enable = true;

      # gsettings reset org.gnome.desktop.calendar show-weekdate
      # or other properties can be tested with reset-recursively
      extraGSettingsOverrides = ''
        # Prefer dark theme
        [org.gnome.desktop.interface]
        color-scheme='prefer-dark'
        icon-theme='Papirus-Dark'
        show-battery-percentage=true
        color-scheme='default'
        monospace-font-name='JetBrainsMono Nerd Font 10'

        [org.gnome.desktop.calendar]
        show-weekdate=true

        # Favorite apps in gnome-shell
        [org.gnome.shell]
        favorite-apps=['org.gnome.Nautilus.desktop','org.gnome.SystemMonitor.desktop','org.gnome.Console.desktop','org.gnome.gitg.desktop','org.xinux.NixSoftwareCenter.desktop','org.xinux.NixosConfEditor.desktop','org.xinux.XinuxModuleManager.desktop','uz.xinux.EIMZOManager.desktop']

        disable-user-extensions=false

        enabled-extensions=['user-theme@gnome-shell-extensions.gcampax.github.com', 'dash-to-dock@micxgx.gmail.com', 'appindicatorsupport@rgcjonas.gmail.com', 'light-style@gnome-shell-extensions.gcampax.github.com', 'system-monitor@gnome-shell-extensions.gcampax.github.com']

        # Workspace should grow dynamically
        # Edge Tiling with mouse
        [org.gnome.mutter]
        dynamic-workspaces=true
        edge-tiling=true

        # Automatic timezone
        [org.gnome.desktop.datetime]
        automatic-timezone=true

        # Never show the notice on tweak
        [org.gnome.tweaks]
        show-extensions-notice=false

        # Show all three button layers
        [org.gnome.desktop.wm.preferences]
        button-layout='appmenu:minimize,maximize,close'

        [org.gnome.desktop.wm.keybindings]
        move-to-monitor-left=@as []
        move-to-monitor-right=@as []

        move-to-workspace-left=['<Super><Shift>Left', '<Shift><Control><Alt>Left']
        move-to-workspace-right=['<Super><Shift>Right', '<Shift><Control><Alt>Right']

        [org.gnome.desktop.peripherals.touchpad]
        click-method='areas'

        # Dash to dock for multiple monitors
        [org.gnome.shell.extensions.dash-to-dock]
        multi-monitor=true
        apply-custom-theme=true
        click-action='minimize'

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
}

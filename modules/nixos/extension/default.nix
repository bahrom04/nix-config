{ pkgs, ... }:
{
  config = {
    # Extensions
    environment.systemPackages = [
      pkgs.gnome-tweaks
      pkgs.gnome-extension-manager
      pkgs.gnomeExtensions.appindicator
      pkgs.gnomeExtensions.dash-to-dock
      pkgs.gnomeExtensions.gsconnect
      pkgs.gnomeExtensions.clipboard-indicator
      # pkgs.gnomeExtensions.gtk4-desktop-icons-ng-ding
      # pkgs.gjs
      # icons
      pkgs.papirus-icon-theme
    ];
  };
}

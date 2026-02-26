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
      # icons
      pkgs.papirus-icon-theme
    ];
  };
}

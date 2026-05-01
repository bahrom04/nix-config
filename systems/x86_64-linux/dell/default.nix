{ lib, ... }:
{
  imports = [
    ./modules.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "uz_UZ.UTF-8";

  networking.hostName = "dell";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/dell/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    flakearg = "dell";
  };

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}

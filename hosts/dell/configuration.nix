{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    # configs for module manager
    ./modules.nix
    # options for module manager
    ../../nixos/xinux/default.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-data.nixosModules.nix-data
    inputs.self.homeModules.nixpkgs
    # inputs.self.homeModules.remote-builder

    inputs.self.homeModules.desktop
    inputs.self.homeModules.keyboard
    inputs.self.homeModules.users.bahrom04

    # system wide apps
    inputs.self.homeModules.nixos.firejail
  ];

  networking.hostName = "dell";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/modules/desktop/apps.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    flakearg = "dell";
  };

  services.e-imzo.enable = true;

  # remove all gnome utility apps
  # services.gnome.core-utilities.enable = false;

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}

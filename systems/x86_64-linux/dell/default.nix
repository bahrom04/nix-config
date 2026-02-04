{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];
  networking.hostName = "dell";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/modules/nixos/apps/default.nixx";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    flakearg = "dell";
  };

  services.e-imzo.enable = true;

  # Select host type for the system
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
}

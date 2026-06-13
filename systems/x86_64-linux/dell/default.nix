{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./modules.nix
    ./hardware-configuration.nix
  ];

  # useful when debugging xeonitte (xinux installer)
  # security.polkit.extraConfig = ''
  #   polkit.addRule(function(action, subject) {
  #     if (subject.isInGroup("wheel"))
  #       return polkit.Result.YES;
  #   });
  # '';

  zramSwap.enable = true;

  boot = {
    kernelPackages = pkgs.linux-cachyos-latest-lto-x86_64-v3;
    supportedFilesystems = [ "ntfs" ];
    consoleLogLevel = 3;
    initrd.systemd.enable = true;
    initrd.verbose = false;

    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

  };

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "uz_UZ.UTF-8";

  networking.hostName = "dell";

  programs.nix-data = {
    enable = true;
    systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/dell/default.nix";
    flake = "/home/bahrom/workplace/bahrom04/nix-config/flake.nix";
    hostname = "dell";
  };

  # Select host type for the system
  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Hardware optimized compilation
  # override
  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "kvm"
    "gccarch-znver3"
    "gccarch-x86-64-v3"
    "gccarch-x86-64-v2"
    "gccarch-x86-64"
  ];
  nixpkgs.localSystem = {
    gcc.arch = "x86-64-v3";
    gcc.tune = "generic";
    system = "x86_64-linux";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = "25.11";
  environment.systemPackages = with pkgs; [
    cryptsetup
  ];
}

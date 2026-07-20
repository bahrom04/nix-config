{
  inputs,
  config,
  modulesPath,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix
  ];

  hardware.facter = {
    enable = true;
    reportPath = ./matax.json;
    detected.graphics.enable = true;
  };

  # https://github.com/sched-ext/scx/blob/main/INSTALL.md#nix
  services.scx = {
    enable = true;
  };

  boot = {
    zswap = {
      enable = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    initrd.systemd.enable = true;
    kernelModules = [ "fuse" ];
    kernelParams = [
      "intel_pstate=active"
    ];
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    supportedFilesystems = [ "ntfs" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  # Hardware optimized compilation
  # https://nixos.wiki/wiki/Build_flags
  nix.settings.system-features = lib.systems.architectures.features.x86-64-v3;
  nixpkgs.hostPlatform = {
    gcc.arch = "x86-64-v3";
    gcc.tune = "generic";
    system = "x86_64-linux";
  };
  nixpkgs.buildPlatform = {
    gcc.arch = "x86-64-v3";
    gcc.tune = "generic";
    system = "x86_64-linux";
  };
  # nixpkgs.localSystem = {
  #   gcc.arch = "x86-64-v3";
  #   gcc.tune = "generic";
  #   system = "x86_64-linux";
  # };

  services.thermald.enable = true;

  hardware = {
    # CPU (Intel/Ryzen) luchshe kupi ryzen: https://www.youtube.com/watch?v=GOkm2C0rk-w
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors (includes 10th Gen)
        intel-vaapi-driver # Optional, for older applications
        vpl-gpu-rt # For modern QSV
        libvdpau
        libva-vdpau-driver
        # vulkan-validation-layers
      ];
    };
    cpu.intel.updateMicrocode = true;
  };
}

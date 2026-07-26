{
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    ./disk-configuration-btrfs.nix
  ];

  hardware.facter = {
    enable = true;
    reportPath = ./dell.json;
    detected.graphics.enable = true;
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
      "mem_sleep_default=deep"
    ];
    supportedFilesystems = [ "ntfs" ];
    # kernel.sysctl = {
    #   "net.core.default_qdisc" = "fq";
    #   "net.ipv4.tcp_congestion_control" = "bbr";
    # };
  };

  # Hardware optimized compilation
  # https://nixos.wiki/wiki/Build_flags
  # nix.settings.system-features = lib.systems.architectures.features.skylake;
  nix.settings.system-features = [
    "gccarch-skylake"
    "gccarch-x86-64-v3"
  ];
  # nixpkgs.hostPlatform = lib.mkForce {
  #   gcc.arch = "skylake";
  #   gcc.tune = "skylake";
  #   system = "x86_64-linux";
  # };
  nixpkgs.hostPlatform = lib.mkForce {
    system = "x86_64-linux";
    gcc.arch = "skylake";
    gcc.tune = "skylake";
    aesSupport = true;
    avxSupport = true;
    avx2Support = true;
    sse3Support = true;
    ssse3Support = true;
    sse4_1Support = true;
    sse4_2Support = true;
  };
  nixpkgs.buildPlatform = lib.mkForce {
    gcc.arch = "skylake";
    gcc.tune = "skylake";
    system = "x86_64-linux";
  };
  # nixpkgs.localSystem = {
  #   gcc.arch = "skylake";
  #   gcc.tune = "skylake";
  #   system = "x86_64-linux";
  # };
  # nixpkgs.hostPlatform = "x86_64-linux";

  # List packages system hardware configuration
  # CPU (Intel/Ryzen) luchshe kupi ryzen: https://www.youtube.com/watch?v=GOkm2C0rk-w
  hardware = {
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
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}

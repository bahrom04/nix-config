{
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disk-configuration.nix

    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # default 50% ram
  zramSwap = {
    enable = true;
    priority = 100;
  };

  boot = {
    kernelPackages = pkgs.linux-cachyos-latest-lto-x86_64-v3;
    supportedFilesystems = [ "ntfs" ];
    consoleLogLevel = 3;
    initrd.systemd.enable = true;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "intel_pstate=active"
    ];
    kernel.sysctl = {
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.watermark_boost_factor" = 0;
      "vm.page-cluster" = 0;
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-intel"
      "fuse"
    ];
    initrd.kernelModules = [ ]; # "nvme"
    extraModulePackages = [ ];
  };

  networking.useDHCP = lib.mkDefault true;

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Hardware optimized compilation
  # https://nixos.wiki/wiki/Build_flags
  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "kvm"
    "gccarch-x86-64-v3"
    "gccarch-x86-64-v2"
    "gccarch-x86-64"
  ];
  nixpkgs.localSystem = {
    gcc.arch = "x86-64-v3";
    gcc.tune = "skylake";
    system = "x86_64-linux";
  };

  services.thermald.enable = true;
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
        vulkan-validation-layers
      ];
    };
    cpu.intel.updateMicrocode = true;
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}

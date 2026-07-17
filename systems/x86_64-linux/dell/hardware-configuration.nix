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

  hardware.facter = {
    enable = true;
    reportPath = ./facter.json;
    detected.graphics.enable = true;
  };

  boot = {
    zswap = {
      enable = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    supportedFilesystems = [ "ntfs" ];
    kernelParams = [
      "systemd.show_status=auto"
      "intel_pstate=active"
      "mem_sleep_default=deep"
    ];
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    initrd.systemd.enable = true;
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
  };

  networking.useDHCP = lib.mkDefault true;

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Hardware optimized compilation
  # https://nixos.wiki/wiki/Build_flags
  nix.settings.system-features = [
    "gccarch-x86-64-v3"
    "gccarch-x86-64-v2"
    "gccarch-x86-64"
  ];
  nixpkgs.localSystem = {
    gcc.arch = "skylake";
    gcc.tune = "skylake";
    system = "x86_64-linux";
  };
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

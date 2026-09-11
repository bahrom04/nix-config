{
  inputs,
  lib,
  modulesPath,
  pkgs,
  config,
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
    reportPath = ./nova.json;
    detected.graphics.enable = true;
  };

  boot = {
    zswap = {
      enable = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    initrd.systemd.enable = true;
    kernelModules = [
      "fuse"
      "nvidia"
    ];
    kernelParams = [
      "intel_pstate=active"
      "mem_sleep_default=deep"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  nix.settings.system-features = [
    "gccarch-x86-64-v3"
  ];
  nixpkgs.buildPlatform = lib.mkForce {
    gcc.arch = "x86-64-v3";
    gcc.tune = "x86-64-v3";
    system = "x86_64-linux";
  };
  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];
  hardware = {
    # CPU (Intel/Ryzen) luchshe kupi ryzen: https://www.youtube.com/watch?v=GOkm2C0rk-w
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement.finegrained = true;
      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:1@0:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        vpl-gpu-rt
        libvdpau
        libva-vdpau-driver
        # vulkan-validation-layers
      ];
    };
    cpu.intel.updateMicrocode = true;
  };
}

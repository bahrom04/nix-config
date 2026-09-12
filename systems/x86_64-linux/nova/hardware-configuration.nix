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

  services.intel-lpmd = {
    enable = true;
    config.meteorLake = true;
    mode = "AUTO";
    debug = true;
  };

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
    initrd.kernelModules = [
      "xe"
      "nvidia"
    ];
    kernelModules = [
      "fuse"
    ];
    kernelParams = [
      "xe.force_probe=7d55"
      "i915.force_probe=!7d55"
      "intel_pstate=active"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  environment.variables = {
    INTEL_XE_IGNORE_EXPERIMENTAL_WARNING = 1;
  };

  environment.sessionVariables = {
    # __GLX_VENDOR_LIBRARY_NAME = "mesa";
    # __NV_PRIME_RENDER_OFFLOAD = "0";
    # GSK_RENDERER = "ngl";
    # VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d";
  };

  services = {
    xserver.videoDrivers = [
      "nvidia"
      "modesetting"
    ];
    gnome.gnome-remote-desktop.enable = false;
  };

  # https://gitlab.gnome.org/GNOME/mutter/-/work_items/2310
  #
  # Actions from: https://github.com/jvdillon/rtx-laptop-linux#5-enable-runtime-pm-via-udev
  services.udev.extraRules = ''
    SUBSYSTEM=="drm", DRIVERS=="nvidia", TAG+="mutter-device-ignore"

    # Force early runtime power management on hardware add phase, matching your 4060 dGPU parameters
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
    ACTION=="change", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
  '';
  hardware = {
    # CPU (Intel/Ryzen) luchshe kupi ryzen: https://www.youtube.com/watch?v=GOkm2C0rk-w
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      dynamicBoost.enable = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        intel-vaapi-driver
        intel-npu-driver
        nvidia-vaapi-driver
        vpl-gpu-rt
        libvdpau
        libva-vdpau-driver
        libva-utils
        # vulkan-validation-layers
      ];
    };
    cpu.intel.updateMicrocode = true;
  };

  nix.settings.system-features = [
    "gccarch-x86-64-v3"
  ];
  nixpkgs.buildPlatform = lib.mkForce {
    gcc.arch = "x86-64-v3";
    gcc.tune = "x86-64-v3";
    system = "x86_64-linux";
  };
}

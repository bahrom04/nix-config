{
  inputs,
  lib,
  modulesPath,
  pkgs,
  config,
  ...
}:
let
  # https://discourse.nixos.org/t/random-freeze-of-system/44766/13
  # https://github.com/NixOS/nixpkgs/pull/561660/changes
  nvidia-615-71-09 = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "615.71.09";
    sha256_64bit = "sha256-zc7tIrvrYSSNGm3qvCWWZz46ZQFpjucayNL9wo87cP4=";
    sha256_aarch64 = "sha256-IbekQhE7cFfmnPZaLY9NDYcF7CoNZ+2Qb7sRd4EOgWM=";
    openSha256 = "sha256-3gByMYIwFzRaLdDG+roCEOuKRRJDrljG9AlLnRZTirM=";
    settingsSha256 = "sha256-LK1LU8mDkM/XVRKPBtuOZh9nIP/lGFLAJnmasEX8jhg=";
    persistencedSha256 = "sha256-qPRb+3d88+2RcpUkoBTbjIaImnQ+jX+/6p1vXcJ5geE=";
  };
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    ./disk-configuration-btrfs.nix
  ];

  hardware.facter = {
    enable = true;
    reportPath = ./nova.json;
    detected.graphics.enable = false;
  };

  boot = {
    extraModulePackages = [
      # (config.boot.kernelPackages.callPackage ./acpi-dkms.nix { })
    ];
    zswap = {
      enable = true;
    };
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
    initrd.systemd.enable = true;
    initrd.kernelModules = [
      "xe"
    ];
    kernelModules = [
      "fuse"
    ];
    kernelParams = [
      "xe.force_probe=7d55"
      "i915.force_probe=!7d55"
    ];
    supportedFilesystems = [ "ntfs" ];
  };

  environment.variables = {
    INTEL_XE_IGNORE_EXPERIMENTAL_WARNING = 1;
  };

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
    __NV_PRIME_RENDER_OFFLOAD = 0;
    GSK_RENDERER = "gl";
    # VK_DRIVER_FILES = "/run/opengl-driver/share/vulkan/icd.d";
  };

  services = {
    xserver.videoDrivers = [
      "nvidia"
    ];
    gnome.gnome-remote-desktop.enable = false;
  };

  # https://gitlab.gnome.org/GNOME/mutter/-/work_items/2310
  #
  # Actions from: https://github.com/jvdillon/rtx-laptop-linux#5-enable-runtime-pm-via-udev
  # SUBSYSTEM=="drm", DRIVERS=="nvidia", TAG+="mutter-device-ignore"
  services.udev.extraRules = ''
    # Enable runtime PM for NVIDIA VGA/3D controller devices on adding device
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
  '';
  hardware = {
    # CPU (Intel/Ryzen) luchshe kupi ryzen: https://www.youtube.com/watch?v=GOkm2C0rk-w
    nvidia = {
      open = true;
      package = nvidia-615-71-09; # 19.09.2026
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
        nvidia-vaapi-driver
        vpl-gpu-rt
        libvdpau
        libva-vdpau-driver
        libva-utils
      ];
    };
    intel-gpu-tools.enable = true;
    cpu.intel = {
      npu.enable = true;
      sgx.enableDcapCompat = false;
    };
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

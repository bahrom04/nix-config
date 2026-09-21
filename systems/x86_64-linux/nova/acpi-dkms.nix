{
  pkgs,
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  kernelModuleMakeFlags,
  kmod,
}:

stdenv.mkDerivation rec {
  pname = "dasharo-acpi-dkms";
  version = "v0.9.1";

  src = /home/bahrom/Projects/bahrom04-lab/dasharo-acpi-dkms/src;

  # sourceRoot = "source/linux/v4l2loopback";
  hardeningDisable = [
    "pic"
    "format"
  ]; # 1
  nativeBuildInputs = kernel.moduleBuildDependencies; # 2

  makeFlags = kernelModuleMakeFlags ++ [
    "KERNELRELEASE=${pkgs.linux.modDirVersion}" # 3
    "KDIR=${pkgs.linux.dev}/lib/modules/${pkgs.linux.modDirVersion}/build" # 4
    "INSTALL_MOD_PATH=$(out)" # 5
  ];

  meta = {
    description = "dasharo-acpi is a Linux kernel driver for hardware monitoring on supported
    platforms with Dasharo firmware.";
    homepage = "https://github.com/aramg/droidcam";
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.makefu ];
    platforms = lib.platforms.linux;
  };
}

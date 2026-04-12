# Snowfall Lib provides access to additional information via a primary argument of
# your overlay.
{
  # Inputs from your flake.
  inputs,
  ...
}:

final: prev: {
  # # Has small chance of kernel modules not being compatible with kernel version.
  linux-cachyos-latest-lto-x86_64-v3 =
    inputs.nix-cachyos-kernel.legacyPackages.${prev.system}.linuxPackages-cachyos-latest-lto-x86_64-v3;
}

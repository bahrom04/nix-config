{
  inputs,
  pkgs,
}:
inputs.xinux-module-manager.packages.${pkgs.stdenv.hostPlatform.system}.xinux-module-manager

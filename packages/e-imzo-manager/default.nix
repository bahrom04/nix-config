{
  inputs,
  pkgs,
}:
inputs.e-imzo-manager.packages.${pkgs.stdenv.hostPlatform.system}.default

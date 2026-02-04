{
  inputs,
  pkgs,
}:
inputs.nix-software-center.packages.${pkgs.stdenv.hostPlatform.system}.default

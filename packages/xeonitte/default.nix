{
  inputs,
  pkgs,
}:
inputs.xeonitte.packages.${pkgs.stdenv.hostPlatform.system}.default

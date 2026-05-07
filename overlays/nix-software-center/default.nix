# Snowfall Lib provides access to additional information via a primary argument of
# your overlay.
{
  # Inputs from your flake.
  inputs,
  ...
}:

final: prev: {
  nix-software-center = inputs.nix-software-center.packages.${prev.stdenv.hostPlatform.system}.default;
}

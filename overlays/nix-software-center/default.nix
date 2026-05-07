# Snowfall Lib provides access to additional information via a primary argument of
# your overlay.
{
  # Inputs from your flake.
  inputs,
  ...
}:

final: prev: {
  e-imzo-manager = inputs.e-imzo-manager.packages.${prev.stdenv.hostPlatform.system}.default;
}

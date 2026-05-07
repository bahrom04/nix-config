# Snowfall Lib provides access to additional information via a primary argument of
# your overlay.
{
  # Inputs from your flake.
  inputs,
  ...
}:

final: prev: {
  xinux-module-manager =
    inputs.xinux-module-manager.packages.${prev.stdenv.hostPlatform.system}.default;
}

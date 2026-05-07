# Snowfall Lib provides access to additional information via a primary argument of
# your overlay.
{
  # Inputs from your flake.
  inputs,
  ...
}:

final: prev: {
  xinux-tour = inputs.xinux-tour.packages.${prev.stdenv.hostPlatform.system}.default;
}

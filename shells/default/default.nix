{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "nix";

  nativeBuildInputs = with pkgs; [
    nixd
    statix
    deadnix
    nixfmt
    nixfmt-tree
    age
    sops
    rng-tools
  ];

  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
}

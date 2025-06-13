{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  name = "nix";

  nativeBuildInputs = with pkgs; [
    nixd
    statix
    deadnix
    alejandra
  ];

  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
}

{ pkgs, ... }:
pkgs.mkShell {
  packages = with pkgs; [
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

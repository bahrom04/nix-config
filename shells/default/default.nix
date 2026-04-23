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
    just
    just-lsp
    just-formatter
  ];

  NIX_CONFIG = "extra-experimental-features = nix-command flakes";
}

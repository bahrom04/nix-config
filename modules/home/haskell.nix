{ pkgs, ... }:
let
  h = pkgs.haskell.packages."ghc910";
in
{
  home.file.".ghci".source = ../../.github/assets/.ghci;

  home.packages = [
    h.ghc
    h.cabal-install
    h.haskell-language-server
    h.cabal-fmt
    h.fourmolu
    pkgs.hlint
    h.ghcprofview
  ];
}
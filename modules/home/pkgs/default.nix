{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # wth
    haskell.packages."ghc910".haskell-language-server
    haskell.packages."ghc910".ghc
    haskell.packages."ghc910".cabal-install
    haskell.packages."ghc910".haskell-language-server
    haskell.packages."ghc910".cabal-fmt
    haskell.packages."ghc910".fourmolu
  ];
}

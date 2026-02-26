{ pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    gnupg # gpg key uchun
    neofetch
    curl
    zip
    xz
    unzip
    jq
    mtr
    dnsutils
    ldns
    nmap
    cowsay
    file
    which
    tree
    btop
    htop
    wl-clipboard
    #espanso-wayland

    # aria2c -x 16 -s 16  "https://CONTENT_PATH"
    aria2

    # wth
    haskell.packages."ghc910".haskell-language-server
    haskell.packages."ghc910".ghc
    haskell.packages."ghc910".cabal-install
    haskell.packages."ghc910".haskell-language-server
    haskell.packages."ghc910".cabal-fmt
    haskell.packages."ghc910".fourmolu
  ];
}

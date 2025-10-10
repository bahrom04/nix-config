{
  pkgs,
  inputs,
  ...
}: {
  imports = with inputs.self; [
    homeModules.direnv
    homeModules.nixpkgs
    #outputs.homeModules.packages
    homeModules.home.git
    homeModules.home.zsh
    homeModules.home.zed
    homeModules.home.ssh
    homeModules.home.fish
    homeModules.home.vscode
    homeModules.home.haskell
    homeModules.home.starship
    homeModules.home.fastfetch
    homeModules.services.espanso
  ];

  home.username = "bahrom04";
  home.homeDirectory = "/Users/bahrom04";

  # Foydalanuvchi profiliga oʻrnatilishi kerak boʻlgan paketlar
  home.packages = with pkgs; [
    git
    gnupg # gpg key uchun
    neofetch

    # arxivlar
    zip
    xz
    unzip
    jq # json ustida ishlovchi yengil va qulay instrument
    mtr # tarmoq diagnostika utilitasi
    dnsutils # `dig` + `nslookup`
    ldns # `dig` o'rnini bosuvchi, `drill` buyrug'ini taqdim etadi
    nmap # tarmoq qidiruvchi va xavfsizlik auditi uchun utilita

    # aria2c -x 16 -s 16  "https://CONTENT_PATH"
    aria2 # multi-protokol va multi-manba'lik buyruq satridagi yuklovchi utilita

    # hokazo
    cowsay
    file
    which
    tree
    # nix-output-monitor
    btop
  ];

  programs.home-manager.enable = true;

  # services.tarjimonlar.enable = true;

  home.stateVersion = "25.05";
}

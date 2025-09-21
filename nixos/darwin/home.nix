{pkgs,outputs, ...}: {
  imports = [
    outputs.homeModules.direnv
    outputs.homeModules.nixpkgs
    #outputs.homeModules.packages
    outputs.homeModules.home.git
    outputs.homeModules.home.zsh
    outputs.homeModules.home.zed
    outputs.homeModules.home.ssh
    outputs.homeModules.home.fish
    outputs.homeModules.home.vscode
    outputs.homeModules.home.haskell
    outputs.homeModules.home.starship
    outputs.homeModules.home.fastfetch
    outputs.homeModules.services.espanso
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

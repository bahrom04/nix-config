{ config, pkgs, ... }:
let
  modulesHome = import ./modules/home;
  modulesServices = import ./modules/services;
in
{
  imports = [
     modulesHome.fastfetch
     modulesHome.fish
     modulesHome.git
     modulesHome.starship
     modulesHome.zsh
     modulesServices.espanso
     modulesServices.vscode
  ];

  home.username = "bahrom04";
  home.homeDirectory = "/Users/bahrom04";

  programs.home-manager.enable = true;
  # home-manager.backupFileExtension = "backup";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
  # Foydalanuvchi profiliga oʻrnatilishi kerak boʻlgan paketlar
  home.packages = with pkgs; [
    # ushbu keltirilganlar men kunlik davomida ishlatadiganlarim
    # o'zingiznikini qo'shish yoki keltirilganlardan olib tashashdan tortinmang
    git
    gnupg # gpg key uchun
    neofetch
    
    # arxivlar
    zip
    xz
    unzip
    
    # utilitalar
    jq # json ustida ishlovchi yengil va qulay instrument    
    # tarmoq utilitalari
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
    # nix ga tegishli
    # 
    # `nom` buyrug'ini beradi va `nix` day ishlaydi
    # tafsilotli log chiqishini ta’minlaydi  
    # nix-output-monitor
    espanso
  ];

  home.stateVersion = "25.05";
}

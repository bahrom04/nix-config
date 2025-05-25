{ config, pkgs, ... }:

{
  home.username = "bahrom04";
  home.homeDirectory = "/Users/bahrom04";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character.success_symbol = "[➜](green)";
      directory.truncation_length = 3;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Foydalanuvchi profiliga oʻrnatilishi kerak boʻlgan paketlar
  home.packages = with pkgs; [
    # ushbu keltirilganlar men kunlik davomida ishlatadiganlarim
    # o'zingiznikini qo'shish yoki keltirilganlardan olib tashashdan tortinmang
    
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
    aria2 # multi-protokol va multi-manba'lik buyruq satridagi yuklovchi utilita
    nmap # tarmoq qidiruvchi va xavfsizlik auditi uchun utilita
 
    
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
  ];

  home.stateVersion = "25.05";


}

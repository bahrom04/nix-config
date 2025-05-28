{ config, pkgs, ... }:

{
  imports = [
     ./modules/fastfetch/default.nix
     ];
  home.username = "bahrom04";
  home.homeDirectory = "/Users/bahrom04";

  programs.home-manager.enable = true;
  # home-manager.backupFileExtension = "backup";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
    '';
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;
    loginShellInit = ''
      eval "$(starship init fish)"
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
  
  ];

  home.file.".aria2/aria2.conf".text = ''
    dir=/Users/${config.home.username}/Downloads
    continue=true
    max-connection-per-server=5
    split=5
    daemon=true
    enable-rpc=true
    rpc-listen-port=6800
    rpc-allow-origin-all=true
  '';

  launchd.agents.aria2 = {
    enable = true;
    config = {
      ProgramArguments = [
        "${pkgs.aria2}/bin/aria2c"
        "--conf-path=$HOME/.aria2/aria2.conf"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      StandartOutPath = "$HOME/Library/Logs/aria2.logs";
      StandartErrorPath = "$HOME/Library/Logs/aria2.err";
    };
  };

  home.stateVersion = "25.05";


}

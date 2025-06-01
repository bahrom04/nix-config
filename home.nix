{ config, pkgs, ... }:
 
{

  imports = [
    ./modules/home/fastfetch.nix
    ./modules/services/espanso.nix
  ];
  
  # Iltimos, foydalanuvchi nomini va uy katalogini oʻz holatingizga moslang
  home.username = "bahrom04";
  home.homeDirectory = "/home/bahrom04";
 
  # Joriy katalogdagi konfiguratsiya faylini koʻrsatilgan joyga bogʻlash
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;
 
  # `./scripts` ichidagi barcha fayllarni `~/.config/i3/scripts` ga bogʻlash
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # rekursiv bogʻlash
  #   executable = true;  # barcha fayllarni bajariladigan qilish
  # };
 
  # Fayl mazmunini toʻgʻridan-toʻgʻri nix konfiguratsiyasiga yozish
  # home.file.".xxx".text = ''
  #     xxx
  # '';
 
  # 4k monitor uchun kursor hajmi va dpi sozlamalari
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };
 
  # Foydalanuvchi profiliga oʻrnatilishi kerak boʻlgan paketlar
  home.packages = with pkgs; [
    # ushbu keltirilganlar men kunlik davomida ishlatadiganlarim
    # o'zingiznikini qo'shish yoki keltirilganlardan olib tashashdan tortinmang
    
    neofetch
    nnn # terminal fayl menejer
    
    # arxivlar
    zip
    xz
    unzip
    p7zip
    
    # utilitalar
    ripgrep # regex tuzilma yordamida kataloglar ichidan rekursiv qidiruv
    jq # json ustida ishlovchi yengil va qulay instrument
    yq-go # yaml ustida ishlovchi
    eza # `ls` o'rniga zamonaviy o'rnini bosuvchi
    fzf # buyruq satrli fuzzy qidiruv utilitasi
    
    # tarmoq utilitalari
    mtr # tarmoq diagnostika utilitasi
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # `dig` o'rnini bosuvchi, `drill` buyrug'ini taqdim etadi
    aria2 # multi-protokol va multi-manba'lik buyruq satridagi yuklovchi utilita
    socat # openbsd-netcat o'rnini bosuvchi
    nmap # tarmoq qidiruvchi va xavfsizlik auditi uchun utilita
    ipcalc # IPv4/v6 lar uchun kalkulyator
    
    # hokazo
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    
    # nix ga tegishli
    # 
    # `nom` buyrug'ini beradi va `nix` day ishlaydi
    # tafsilotli log chiqishini ta’minlaydi
    nix-output-monitor
    
    # mahsuldorlik
    hugo # statik sayt yaratish vositasi
    glow # terminalda markdown ko‘ruvchisi
    
    btop # htop/nmon o'rnini bosuvchi
    iotop # io (chiqim/kirim) ko'rsatib turuvchi
    iftop # tarmoq ko'rsatib turuvchi
    
    # tizim chaqiruvchi monitoring
    strace # tizimga bo'lgan chaqiruvlar monitoringi
    ltrace # kutubxonalardan bo'lgan chaqiruvlar monitoringi
    lsof # ochilgan fayllar ro'yxatlovchi
    
    # tizim utilitalari
    sysstat
    lm_sensors # `sensors` buyrug'i uchun
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
 
  # oddiy git sozlamari, o'zingizga moslang
  programs.git = {
    enable = true;
    userName = "Ryan Yin";
    userEmail = "xiaoyin_c@qq.com";
  };
 
  # starship - istalgan buyruq satri ko'rinishi o'zgartiruvchi
  programs.starship = {
    enable = true;
    # moslangan sozlamalar
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };
 
  # alacritty - platformalarar-o, GPU orqali tezlatilgan buyruq satr emulyatori
  programs.alacritty = {
    enable = true;
    # moslangan sozlamalar
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
 
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # ESLATMA o'zingizni bashrc'ingizni qo'shib keting
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    
    # qiqartma nomlar qo'shing, xoh qo'shing, xoh olib tashlang
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
 
  # Bu qiymat qaysi versiyadagi home-manager sozlamari bilan
  # to'g'ri kelishini belgilaydi. Bu ko'proq home manager ning
  # eski versiya bilan chiqishmaydigan yangi versiyasi chiqganda
  # buzilib qolishlar oldini oladi.
  # 
  # Shu qiymat o'zgartirmayam home manager yangilasa bo'ladi. Ba'tafsil
  # har bir relizda bo'lgan o'zgarishlar home managerning relizlar 
  # eslatmasida ko'zdan kechirib chiqing.
  home.stateVersion = "24.11";
 
  # Home Manager o'zini o'rnatishiga qo'yib beraylik
  programs.home-manager.enable = true;
}
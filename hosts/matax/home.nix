{inputs, ...}: {
  imports = with inputs.self;[
    homeModules.direnv
    homeModules.nixpkgs
    homeModules.packages
    homeModules.home.git
    homeModules.home.zsh
    homeModules.home.zed
    homeModules.home.ssh
    homeModules.home.fish
    homeModules.home.vscode
    homeModules.home.haskell
    homeModules.home.starship
    homeModules.home.fastfetch
    #outputs.homeModules.home.zen-browser
    # outputs.homeModules.services.espanso
  ];

  home.username = "bahrom";
  home.homeDirectory = "/home/bahrom";
  home.keyboard = null;
  
  programs.home-manager.enable = true;

  # services.tarjimonlar.enable = true;
}

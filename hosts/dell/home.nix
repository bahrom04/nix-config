{inputs, ...}: {
  imports = with inputs.self; [
    homeModules.direnv
    homeModules.nixpkgs
    homeModules.home.git
    homeModules.home.zsh
    homeModules.home.zed
    homeModules.home.ssh
    homeModules.home.fish
    homeModules.home.vscode
    #homeModules.home.haskell
    homeModules.home.starship
    homeModules.home.packages
    homeModules.home.fastfetch
    #outputs.homeModules.home.zen-browser
    # outputs.homeModules.services.espanso
  ];

  # home.keyboard = null;
  home = {
    username = "bahrom";
    homeDirectory = "/home/bahrom";
    
    keyboard = {
      layout = "uz";
      variant = "latin";
    };
  };

  programs.home-manager.enable = true;

  # services.tarjimonlar.enable = true;
}

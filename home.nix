{outputs, ...}: {
  imports = [
    outputs.homeModules.direnv
    outputs.homeModules.nixpkgs
    outputs.homeModules.packages
    outputs.homeModules.home.git
    outputs.homeModules.home.zsh
    outputs.homeModules.home.zed
    outputs.homeModules.home.ssh
    outputs.homeModules.home.fish
    # outputs.homeModules.home.vscode
    outputs.homeModules.home.haskell
    outputs.homeModules.home.starship
    outputs.homeModules.home.fastfetch
    # outputs.homeModules.services.espanso
  ];

  programs.home-manager.enable = true;

  # services.tarjimonlar.enable = true;
}

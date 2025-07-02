{pkgs, ...}: let
  homeModules = import ./modules;
in {
  imports = [
    homeModules.packages
    homeModules.nixpkgs
    homeModules.direnv
    homeModules.home.fastfetch
    homeModules.home.fish
    homeModules.home.git
    homeModules.home.starship
    homeModules.home.zsh
    homeModules.home.vscode
    homeModules.services.espanso
  ];

  programs.home-manager.enable = true;
  # home-manager.backupFileExtension = "backup";

  # services.tarjimonlar.enable = true;
}

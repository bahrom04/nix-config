{ config, pkgs, ... }:

{
  home.username = "bahrom04";


  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
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

  home.stateVersion = "25.05";


}

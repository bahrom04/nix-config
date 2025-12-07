{pkgs, ...}: {
  config = {
    programs.nix-ld.enable = true;

    environment = {
      systemPackages = with pkgs; [
        nixfmt-rfc-style
        neovim
        vim
        fastfetch
        age
        sops
        hunspell
        hunspellDicts.uz_UZ
        rng-tools
        pinentry-gnome3
        haveged
        xorg.setxkbmap
        xorg.xkbcomp
        # Services
        # redis
      ];
    };
  };
}

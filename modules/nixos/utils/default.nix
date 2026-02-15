{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
  alejandra = inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system};
in {
  config = {
    programs.nix-ld = {
      enable = lib.mkDefault true;
      libraries = with pkgs; [
        acl
        attr
        bzip2
        curl
        libglvnd
        libsodium
        libssh
        libxml2
        mesa
        openssl
        stdenv.cc.cc
        systemd
        util-linux
        vulkan-loader
        xz
        zlib
        zstd
      ];
    };
    services.envfs.enable = lib.mkDefault true;

    environment = {
      variables = {
        EDITOR = "vim";
        SOPS_AGE_KEY_FILE = age_keys;
      };
      systemPackages = with pkgs; [
        # fonts
        freefont_ttf
        #formatter
        alejandra
        nixfmt

        gnome-user-share
        desktop-file-utils
        neovim
        vim
        fastfetch
        xkbcomp
        setxkbmap
        rng-tools
        haveged
        flatpak-builder
        woeusb # for creating windows usb

        # git/hub
        age
        sops
        pinentry-gnome3

        # l10n
        hunspell
        hunspellDicts.uz_UZ
        # Services
        # redis
      ];
    };
  };
}

{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
  nix-software-center = inputs.nix-software-center.packages."${pkgs.stdenv.hostPlatform.system}".default;
  xinux-module-manager = inputs.xinux-module-manager.packages."${pkgs.stdenv.hostPlatform.system}".xinux-module-manager;
  nixos-conf-editor = inputs.nixos-conf-editor.packages."${pkgs.stdenv.hostPlatform.system}".nixos-conf-editor;
  e-imzo-manager = inputs.e-imzo-manager.packages."${pkgs.stdenv.hostPlatform.system}".default;
  xinux-wallpapers = lib.recurseIntoAttrs (pkgs.callPackage ./wallpapers.nix {});
  alejandra = inputs.alejandra.defaultPackage.${pkgs.stdenv.hostPlatform.system};
in {
  config = {
    # APPS
    environment = {
      variables = {
        EDITOR = "vim";
        SOPS_AGE_KEY_FILE = age_keys;
      };
      systemPackages = [
        pkgs.flatpak-builder
        pkgs.gnome-builder
        pkgs.fractal
        pkgs.authenticator
        pkgs.libreoffice
        pkgs.postman
        pkgs.poedit

        pkgs.gnome-boxes
        pkgs.googleearth-pro
        pkgs.prismlauncher
        pkgs.github-desktop
        pkgs.thunderbird
        pkgs.android-studio

        pkgs.element-desktop
        pkgs.telegram-desktop
        pkgs.discord
        # some apps
        pkgs.onlyoffice-desktopeditors

        #formatter
        alejandra
        # utils
        pkgs.desktop-file-utils

        # Browsers
        pkgs.google-chrome
        pkgs.chromium
        pkgs.ungoogled-chromium

        # Xinux apps
        nix-software-center
        xinux-module-manager
        nixos-conf-editor
        e-imzo-manager
        pkgs.snowfallorg.drift
        # xinux-wallpapers
        xinux-wallpapers.xinux-blue-light
        xinux-wallpapers.xinux-blue-dark
        xinux-wallpapers.xinux-orange
      ];
      # exclude apps
      # gnome.excludePackages = with pkgs; [
      #   # gnome-tour
      #   # gnome-backgrounds
      # ];
    };
  };
}

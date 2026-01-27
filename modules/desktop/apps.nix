{
  pkgs,
  inputs,
  lib,
  ...
}: let
  xeonitte = inputs.xeonitte.packages."${pkgs.stdenv.hostPlatform.system}".default;
  nix-software-center = inputs.nix-software-center.packages."${pkgs.stdenv.hostPlatform.system}".default;
  xinux-module-manager = inputs.xinux-module-manager.packages."${pkgs.stdenv.hostPlatform.system}".xinux-module-manager;
  nixos-conf-editor = inputs.nixos-conf-editor.packages."${pkgs.stdenv.hostPlatform.system}".nixos-conf-editor;
  e-imzo-manager = inputs.e-imzo-manager.packages."${pkgs.stdenv.hostPlatform.system}".default;
  # poedit = pkgs.poedit.overrideDerivation (oldAttrs: {
  #   pname = "poedit";
  #   version = "3.6.2";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "vslavik";
  #     repo = "poedit";
  #     rev = "v3.5.2-oss";
  #     hash = "sha256-Lb1R7GMB0GeS2xZASR7w4ee33mMEKP9gPabRHkHlIJI=";
  #   };
  #   patches = [];
  # });
in {
  # APPS
  environment.systemPackages = [
    # Xinux apps
    # xeonitte
    # nix-software-center
    # xinux-module-manager
    # nixos-conf-editor
    # e-imzo-manager
    # pkgs.snowfallorg.drift

    pkgs.gnome-builder
    pkgs.fractal
    pkgs.authenticator
    pkgs.libreoffice
    pkgs.gnome-boxes
    pkgs.prismlauncher
    pkgs.thunderbird
    pkgs.onlyoffice-desktopeditors
    pkgs.postman
    pkgs.gtranslator
    # poedit
    pkgs.googleearth-pro
    pkgs.google-chrome
    pkgs.chromium
    pkgs.github-desktop
    pkgs.element-desktop
    pkgs.telegram-desktop
    pkgs.discord
    # pkgs.ciscoPacketTracer8 waiting for 9 come out
    # pkgs.android-studio
    pkgs.boltbrowser
    pkgs.kstars
    pkgs.gnome-solanum
    pkgs.nextcloud-client
    pkgs.icon-library
    pkgs.calamares-nixos
    pkgs.gnome-podcasts
    pkgs.cambalache
    pkgs.adwsteamgtk
    pkgs.bustle
    pkgs.firefox
    pkgs.gradia
    pkgs.dialect
    pkgs.cpu-x
    pkgs.sqlitebrowser
    pkgs.blanket
  ];
}

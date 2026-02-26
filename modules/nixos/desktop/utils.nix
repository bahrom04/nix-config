{
  pkgs,
  lib,
  config,
  ...
}: let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
in {
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

  programs.fuse = {
    enable = true;
    userAllowOther = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.fuse # Provides FUSE 2 support
        pkgs.libpulseaudio # Often needed for sound in AppImages
      ];
    };
  };

  environment = {
    variables = {
      EDITOR = "vim";
      SOPS_AGE_KEY_FILE = age_keys;
    };
  };
}

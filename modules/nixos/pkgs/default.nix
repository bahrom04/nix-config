{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  xinux-settings = inputs.xinux-settings.packages.${pkgs.stdenv.hostPlatform.system}.xinux-settings;
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
in
{
  # APPS
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    papirus-icon-theme
    # formatter
    nixfmt-tree
    nixfmt
    nixpkgs-review
    # fonts
    freefont_ttf
    gnome-user-share
    desktop-file-utils
    neovim
    vim
    fastfetch
    onefetch
    xkbcomp
    setxkbmap
    rng-tools
    haveged
    flatpak-builder
    woeusb # for creating windows usb
    ntfs3g

    fuse # version 2 for appimages
    appimage-run

    # git/hub
    age
    sops
    pinentry-gnome3

    # l10n
    hunspell
    hunspellDicts.uz_UZ
    # Services
    # redis
    # support both 32-bit and 64-bit applications
    wineWow64Packages.stable
    samba # Provides ntlm_auth
    krb5 # Provides Kerberos support libraries
    winetricks # Useful for further troubleshooting
    gnome-builder
    fractal
    # authenticator
    libreoffice
    gnome-boxes
    # prismlauncher
    # gparted
    googleearth-pro
    onlyoffice-desktopeditors
    # postman
    gtranslator
    google-chrome
    brave
    # chromium
    github-desktop
    element-desktop
    telegram-desktop
    discord
    # kstars
    # gnome-solanum
    nextcloud-client
    icon-library
    gnome-podcasts
    # cambalache
    bustle
    d-spy
    firefox
    gradia
    dialect
    cpu-x
    sqlitebrowser
    blanket
    cisco-packet-tracer_9
    # autopsy
    e-imzo-manager
    software-center
    xinux-module-manager
    xinux-settings
    xeonitte
    obsidian
    crosswords
    (poedit.override { boost = boost188; })
    # cosmic-settings
    # cosmic-settings-daemon
    burpsuite
    zap
    seclists
    # veracrypt
    # cryptomator
    # kdePackages.kleopatra
    # hashcat
    wireshark
    sysprof
    # constrict
    # winboat
    # pods
    # podman
    # opensnitch-ui
    # virtualbox
    # vmware-workstation
    # tailor_gui
    # openscad-lsp
    # openscad
  ];

  # advansed option. Adding just pkgs.x is not enough
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
      ];
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    fuse = {
      enable = true;
      userAllowOther = true;
    };
    appimage = {
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
    nix-ld = {
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
    zsh.enable = true;
    mtr.enable = true;
    steam.enable = true;
  };
}

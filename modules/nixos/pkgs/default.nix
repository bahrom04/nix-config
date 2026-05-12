{
  pkgs,
  config,
  lib,
  ...
}:
let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
in
{
  # APPS
  environment = {
    variables = {
      EDITOR = "vim";
      SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.clipboard-indicator
      papirus-icon-theme
      gnome-power-manager
      # formatter
      nixfmt-tree
      nixfmt
      nixpkgs-review
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
      libva-utils
      intel-gpu-tools
      fuse # version 2 for appimages
      appimage-run
      # git/hub
      age
      sops
      pinentry-gnome3
      hunspell
      hunspellDicts.uz_UZ
      helix
      # redis
      # support both 32-bit and 64-bit applications
      wineWow64Packages.stable
      samba # Provides ntlm_auth
      krb5 # Provides Kerberos support libraries
      winetricks
      gnome-builder
      fractal
      putty
      # authenticator
      # libreoffice
      libreoffice-fresh
      gnome-boxes
      # prismlauncher
      googleearth-pro
      onlyoffice-desktopeditors
      # postman
      gtranslator
      google-chrome
      brave
      github-desktop
      element-desktop
      telegram-desktop
      discord
      # gnome-solanum
      nextcloud-client
      icon-library
      gnome-podcasts
      # cambalache
      bustle
      d-spy
      gradia
      # dialect
      cpu-x
      sqlitebrowser
      blanket
      cisco-packet-tracer_9
      # autopsy
      e-imzo-manager
      nix-software-center
      xinux-module-manager
      xinux-settings
      xinux-tour
      bleur
      # xeonitte
      obsidian
      crosswords
      poedit
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
      impression
    ];
  };

  # advansed option. Adding just pkgs.x is not enough
  programs = {
    firefox = {
      enable = true;
      preferences = {
        "spellchecker.dictionary_path" =
          let
            dictionary = pkgs.symlinkJoin {
              name = "firefox-hunspell-dicts";
              paths = with pkgs.hunspellDicts; [
                en-us-large
                ru-ru
                uz-uz
              ];
            };
          in
          "${dictionary}/share/hunspell";
        "layout.spellcheckDefault" = 2;
      };
    };
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
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      # History file
      histSize = 5000;
      vteIntegration = true;
      direnv.enableZshIntegration = true;
      shellInit = ''
        export GPG_TTY="$(tty)"
      '';
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    mtr.enable = true;
    steam.enable = false;
  };
}

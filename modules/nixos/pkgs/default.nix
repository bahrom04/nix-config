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
      EDITOR = "hx";
      SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs; [
      gnome-tweaks
      gnome-power-manager
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gnome-shell-extensions
      # formatter
      nixfmt-tree
      nixfmt
      nixpkgs-review
      nix-output-monitor
      nix-fast-build
      gnome-user-share
      desktop-file-utils
      neovim
      helix
      fastfetch
      onefetch
      tree
      jq
      jq-zsh-plugin
      jq-lsp
      asciinema
      flatpak-builder
      woeusb # for creating windows usb
      libva-utils
      intel-gpu-tools
      fuse # version 2 for appimages
      appimage-run
      age
      sops
      pinentry-gnome3
      hunspell
      hunspellDicts.uz_UZ
      wineWow64Packages.stable
      samba # Provides ntlm_auth
      krb5 # Provides Kerberos support libraries
      winetricks
      ############################ GNOME
      gnome-builder
      gnome-boxes
      gnome-graphs
      gnome-podcasts
      dconf-editor
      icon-library
      resources
      blanket
      fractal
      crosswords
      impression
      bustle
      d-spy
      gradia
      cpu-x
      libreoffice-fresh
      googleearth-pro
      google-chrome
      epiphany
      github-desktop
      gitte
      element-desktop
      telegram-desktop
      discord
      sqlitebrowser
      nix-software-center
      xinux-settings
      xinux-tour
      bleur
      poedit
      wireshark
      sysprof
      zap
      seclists
      burpsuite
      geekbench
      wl-clipboard
      # nextcloud-client
      # gtranslator
      # putty
      # authenticator
      # libreoffice
      # onlyoffice-desktopeditors
      # prismlauncher
      # postman
      # cisco-packet-tracer_9
      # bitwarden-desktop
      # cambalache
      # dialect
      # autopsy
      # xeonitte
      # cosmic-settings
      # cosmic-settings-daemon
      # kdePackages.kleopatra
      # hashcat
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
  };

  # advansed option. Adding just pkgs.x is not enough
  programs = {
    nh = {
      enable = true;
      flake = "/home/bahrom/workplace/bahrom04/nix-config"; # sets NH_OS_FLAKE variable for you
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
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
      shellInit = ''
        eval "$(starship init zsh)"
        export GPG_TTY="$(tty)"
      '';
    };
    # prettier terminal prompt
    starship.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    steam.enable = true;
  };
}

{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  # age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
  #   pkgs = inputs.nixpkgs> {
  #     localSystem = {
  #       gcc.arch = "x86-64-v3";
  #       gcc.tune = "generic";
  #       system = "x86_64-linux";
  #     };
  #   };
in
{
  # imports = [
  #   inputs.chaotic.nixosModules.default
  # ];
  environment = {
    variables = {
      EDITOR = "hx";
      # SOPS_AGE_KEY_FILE = age_keys;
    };
    systemPackages = with pkgs; [
      # authenticator
      # autopsy
      # bitwarden-desktop
      # cambalache
      # cisco-packet-tracer_9
      # cosmic-settings
      # cosmic-settings-daemon
      # dialect
      # formatter
      # gearlever
      # gtk devel
      # gtranslator
      # hashcat
      # kdePackages.kleopatra
      # nextcloud-client
      # onlyoffice-desktopeditors
      # openscad
      # openscad-lsp
      # opensnitch-ui
      # podman
      # pods
      # postman
      # prismlauncher
      # tailor_gui
      # virtualbox
      # vmware-workstation
      # winboat
      # xeonitte
      ############################ GNOME
      #burpsuite
      #nix-software-center
      #seclists
      #wireshark
      #xinux-tour
      #zap
      age
      app-icon-preview
      appimage-run
      appstream
      asciinema
      blanket
      bleur
      bustle
      cairo
      cargo
      cargo-audit
      cargo-expand
      clippy
      code-nautilus
      constrict
      cpu-x
      cpufetch
      crosswords
      deadnix
      desktop-file-utils
      discord
      disko
      element-desktop
      elfx86exts
      epiphany
      fastfetch
      ffmpeg
      file
      flatpak-builder
      fractal
      fuse # version 2 for appimages
      gamemode
      gdk-pixbuf
      geekbench
      gitte
      gnome-boxes
      gnome-graphs
      gnome-initial-setup
      gnome-podcasts
      gnome-power-manager
      gnome-shell-extensions
      gnome-tweaks
      gnome-user-share
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      gobject-introspection
      google-chrome
      gpufetch
      gradia
      gtk4
      gtksourceview5
      helix
      htop
      hunspell
      hunspellDicts.uz_UZ
      icon-library
      ifuse # optional, to mount using 'ifuse'
      impression
      inkscape-with-extensions
      intel-gpu-tools
      iotop
      jq
      jq-lsp
      jq-zsh-plugin
      kdiskmark
      krb5 # Provides Kerberos support libraries
      lact
      libadwaita
      libimobiledevice
      libreoffice
      libva-utils
      libxml2
      lm_sensors
      localsend
      mangohud
      meson
      mission-center
      mpv
      nautilus-python
      neovim
      ninja
      nix-fast-build
      nix-output-monitor
      nixd
      nixfmt
      nixfmt-tree
      nixpkgs-review
      nvd
      onefetch
      openssl
      pango
      pciutils
      pinentry-gnome3
      pkg-config
      poedit
      powertop
      psmisc
      qdiskinfo
      resources
      rust-analyzer
      rustc
      rustfmt
      samba # Provides ntlm_auth
      sops
      sqlitebrowser
      statix
      telegram-desktop
      tree
      usbutils
      winetricks
      wineWow64Packages.stable
      wl-clipboard
      woeusb # for creating windows usb
      xcp
      xinux-settings
    ];
  };

  services.gnome.core-developer-tools.enable = true;
  # advansed option. Adding just pkgs.x is not enough
  programs = {
    nh = {
      enable = true;
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
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      vteIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    # prettier terminal prompt
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    steam = {
      enable = true;
      # 1 option
      # extraCompatPackages = with pkgs; [ proton-cachyos-x86_64_v3 ];
      # 2 option. chaotic
      # https://www.nyx.chaotic.cx/#:~:text=proton%2Dcachyos%5Fx86%5F64%5Fv3
      extraCompatPackages = [
        # inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos_x86_64_v3
      ];
    };
  };
}

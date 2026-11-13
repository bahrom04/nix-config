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
      jq
      age
      mpv
      nvd
      xcp
      file
      gtk4
      htop
      lact
      nixd
      sops
      tree
      bleur
      cairo
      cargo
      cpu-x
      disko
      gitte
      helix
      iotop
      meson
      ninja
      pango
      rustc
      bustle
      clippy
      ffmpeg
      gradia
      jq-lsp
      neovim
      nixfmt
      poedit
      psmisc
      statix
      blanket
      deadnix
      discord
      fractal
      libxml2
      openssl
      rustfmt
      cpufetch
      epiphany
      gamemode
      gpufetch
      hunspell
      mangohud
      onefetch
      pciutils
      powertop
      usbutils
      appstream
      asciinema
      constrict
      fastfetch
      geekbench
      kdiskmark
      localsend
      qdiskinfo
      resources
      crosswords
      elfx86exts
      gdk-pixbuf
      impression
      libadwaita
      lm_sensors
      pkg-config
      winetricks
      # formatter
      # gearlever
      # gtk devel
      cargo-audit
      gnome-boxes
      libreoffice
      libva-utils
      nixfmt-tree
      appimage-run
      cargo-expand
      gnome-graphs
      gnome-tweaks
      icon-library
      wl-clipboard
      code-nautilus
      google-chrome
      jq-zsh-plugin
      rust-analyzer
      sqlitebrowser
      gnome-podcasts
      gtksourceview5
      mission-center
      nix-fast-build
      nixpkgs-review
      xinux-settings
      element-desktop
      flatpak-builder
      intel-gpu-tools
      nautilus-python
      pinentry-gnome3
      app-icon-preview
      gnome-user-share
      libimobiledevice
      telegram-desktop
      desktop-file-utils
      nix-output-monitor
      gnome-initial-setup
      gnome-power-manager
      hunspellDicts.uz_UZ
      gobject-introspection
      gnome-shell-extensions
      inkscape-with-extensions
      wineWow64Packages.stable
      samba # Provides ntlm_auth
      fuse # version 2 for appimages
      woeusb # for creating windows usb
      ############################ GNOME
      ifuse # optional, to mount using 'ifuse'
      gnomeExtensions.gtk4-desktop-icons-ng-ding
      krb5 # Provides Kerberos support libraries
      #nix-software-center
      #xinux-tour
      #wireshark
      #zap
      #seclists
      #burpsuite
      # nextcloud-client
      # gtranslator
      # authenticator
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

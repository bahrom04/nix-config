{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
let
  age_keys = "${config.users.users.bahrom.home}/.config/sops/age/keys.txt";
in
{
  # imports = [
  #   inputs.chaotic.nixosModules.default
  # ];
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
      nautilus-python
      code-nautilus
      # formatter
      nixfmt-tree
      nixfmt
      nixpkgs-review
      nix-output-monitor
      nix-fast-build
      gnome-user-share
      neovim
      helix
      fastfetch
      onefetch
      ffmpeg
      mpv
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
      app-icon-preview
      resources
      blanket
      fractal
      crosswords
      impression
      bustle
      d-spy
      gradia
      cpu-x
      qdiskinfo
      kdiskmark
      libreoffice-fresh
      collabora-online
      collabora-desktop
      googleearth-pro
      google-chrome
      epiphany
      gitte
      element-desktop
      telegram-desktop
      discord
      sqlitebrowser
      nix-software-center
      # xinux-settings
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
      stress-ng
      rt-tests
      # nextcloud-client
      # gtranslator
      # putty
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
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
      vteIntegration = true;
      shellInit = ''
        eval "$(starship init zsh)"
        export GPG_TTY="$(tty)"
      '';
    };
    # prettier terminal prompt
    starship.enable = true;
    steam = {
      enable = true;
      # 1 option
      # extraCompatPackages = with pkgs; [ proton-cachyos-x86_64_v3 ];
      # 2 option. chaotic
      # https://www.nyx.chaotic.cx/#:~:text=proton%2Dcachyos%5Fx86%5F64%5Fv3
      extraCompatPackages = [
        inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos_x86_64_v3
      ];
    };
  };
}

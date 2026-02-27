{ pkgs, ... }:
{
  # APPS
  environment.systemPackages = with pkgs; [
    # formatter
    nixfmt-tree
    nixfmt
    # fonts
    freefont_ttf
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
    protontricks

    gnome-builder
    fractal
    authenticator
    libreoffice
    gnome-boxes
    prismlauncher
    gparted
    googleearth-pro
    thunderbird
    onlyoffice-desktopeditors
    postman
    gtranslator
    google-chrome
    chromium
    github-desktop
    element-desktop
    telegram-desktop
    discord
    boltbrowser
    kstars
    gnome-solanum
    nextcloud-client
    icon-library
    gnome-podcasts
    cambalache
    adwsteamgtk
    bustle
    d-spy
    firefox
    gradia
    dialect
    cpu-x
    sqlitebrowser
    blanket
    cisco-packet-tracer_9
    autopsy
    obs-studio
    e-imzo-manager
    obsidian
    # poedit.override { boo}
    nixpkgs-review
    xeonitte
    burpsuite
    zap
    cosmic-settings
    cosmic-settings-daemon
  ];
}

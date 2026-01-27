{pkgs, ...}: {
  # APPS
  environment.systemPackages = with pkgs;[
    gnome-builder
    fractal
    authenticator
    libreoffice
    gnome-boxes
    prismlauncher
    thunderbird
    onlyoffice-desktopeditors
    postman
    gtranslator
    # poedit
    googleearth-pro
    google-chrome
    chromium
    github-desktop
    element-desktop
    telegram-desktop
    discord
    # ciscoPacketTracer8 waiting for 9 come out
    # android-studio
    boltbrowser
    kstars
    gnome-solanum
    nextcloud-client
    icon-library
    calamares-nixos
    gnome-podcasts
    cambalache
    adwsteamgtk
    bustle
    firefox
    gradia
    dialect
    cpu-x
    sqlitebrowser
    blanket
  ];
}

{pkgs, ...}: {
  # APPS
  environment.systemPackages = [
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

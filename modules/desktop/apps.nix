{pkgs, ...}: {
  # APPS
  environment.systemPackages = with pkgs; [
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
    calls
    # ciscoPacketTracer9
    
    # support both 32-bit and 64-bit applications
    wineWowPackages.stable
    samba # Provides ntlm_auth
    krb5 # Provides Kerberos support libraries
    winetricks # Useful for further troubleshooting
  ];
}

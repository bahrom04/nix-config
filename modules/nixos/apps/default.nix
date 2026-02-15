{pkgs, ...}: {
  # APPS
  environment.systemPackages = with pkgs; [
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
    thunderbird
    onlyoffice-desktopeditors
    postman
    gtranslator
    googleearth-pro
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
    cisco-packet-tracer_9
    autopsy
    obs-studio
    e-imzo-manager
    obsidian
    # poedit.override { boo}
    nixpkgs-review
  ];
}

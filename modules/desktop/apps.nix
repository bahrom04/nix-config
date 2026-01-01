{
  pkgs,
  inputs,
  ...
}: let
  nix-software-center = inputs.nix-software-center.packages."${pkgs.stdenv.hostPlatform.system}".default;
  xinux-module-manager = inputs.xinux-module-manager.packages."${pkgs.stdenv.hostPlatform.system}".xinux-module-manager;
  nixos-conf-editor = inputs.nixos-conf-editor.packages."${pkgs.stdenv.hostPlatform.system}".nixos-conf-editor;
  e-imzo-manager = inputs.e-imzo-manager.packages."${pkgs.stdenv.hostPlatform.system}".default;
in {
  config = {
    # APPS
    environment = {
      systemPackages = [
        pkgs.gnome-builder
        pkgs.fractal
        pkgs.authenticator
        pkgs.libreoffice
        pkgs.gnome-boxes
        pkgs.prismlauncher
        pkgs.thunderbird
        pkgs.onlyoffice-desktopeditors
        pkgs.postman
        pkgs.poedit

        pkgs.googleearth-pro
        pkgs.google-chrome
        pkgs.chromium
        pkgs.github-desktop
        pkgs.element-desktop
        pkgs.telegram-desktop
        pkgs.discord
        # pkgs.android-studio
        
        # Xinux apps
        nix-software-center
        xinux-module-manager
        nixos-conf-editor
        e-imzo-manager
        pkgs.snowfallorg.drift
      ];
      # exclude apps
      # gnome.excludePackages = with pkgs; [
      #   # gnome-tour
      #   # gnome-backgrounds
      # ];
    };
  };
}

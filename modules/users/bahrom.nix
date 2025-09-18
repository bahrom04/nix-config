{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  inherit (inputs.self) lib;

  # Packages that are not aarch64 compatible
  x86_64-only =
    lib.condition.mkArrIf
    pkgs.stdenv.hostPlatform.isx86_64
    (with pkgs; [
      # Latest discord
      pkgs.discord
      # To patch discord's krisp
      pkgs.krisper
      # Zoom conference
      zoom-us
    ]);

  packages =
    (with pkgs; [
      # Matrix client
      fractal
      # Mastodon client
      tuba
      # Telegram desktop
      unstable.telegram-desktop
      # GitHub Desktop
      github-desktop
      # RDP Management
      remmina
    ])
    ++ x86_64-only;

  hashedPassword = "$2b$05$QgiAihjGOtxfGZ06pfm2u.dMR6522sT2Pmy4mt//Rf2x5YonDcD.2";
in {
  config = {
    users.users = {
      bahrom = {
        inherit packages hashedPassword;
        isNormalUser = true;
        description = "Bakhrom Rakhmatov";

        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "vboxusers"
          "media"
          "admins"
          "libvirtd"
        ];

        openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
          builtins.readFile (
            builtins.fetchurl {
              url = "https://github.com/bahrom04.keys";
              sha256 = "";
            }
          )
        );
      };
    };

    home-manager = {
      backupFileExtension = "hbak";
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      users = {
        # Import your home-manager configuration
        sakhib = import ../../../home.nix;
      };
    };
  };
}

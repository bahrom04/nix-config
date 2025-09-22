{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: let
  hashedPassword = "$2b$05$QgiAihjGOtxfGZ06pfm2u.dMR6522sT2Pmy4mt//Rf2x5YonDcD.2";
in {
  config = {
    users.users = {
      bahrom = {
        inherit hashedPassword;
        isNormalUser = true;
        description = "Bakhrom Rakhmatov";
        shell = pkgs.zsh;
        
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
        bahrom = import ../../home.nix;
      };
    };
  };
}

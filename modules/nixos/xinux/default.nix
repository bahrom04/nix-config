{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.xinux;
in {
  imports = [
  ];

  options.modules.xinux = with types; {
    nixSoftwareCenter.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable Nix Software Center, a graphical software center for Nix";
    };
    nixosConfEditor.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable NixOS Configuration Editor, a graphical editor for NixOS configurations";
    };
    xinuxModuleManager.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable Xinux Module Manager, a graphical tool for managing Xinux modules";
    };
    eimzoIntegraion.enable = mkOption {
      type = bool;
      default = false;
      description = "Enable services and install software of E-IMZO for easier management of keys";
    };
    language = mkOption {
      type = enum ["uz_UZ.UTF-8" "en_US.UTF-8" "ru_RU.UTF-8"];
      default = "uz_UZ.UTF-8";
      description = "set language";
    };
  };
  config = mkMerge [
    (mkIf cfg.nixSoftwareCenter.enable {
      environment.systemPackages = with pkgs; [
        software-center
      ];
    })
    (mkIf cfg.nixosConfEditor.enable {
      environment.systemPackages = with inputs; [
        nixos-conf-editor.packages.${pkgs.stdenv.hostPlatform.system}.nixos-conf-editor
      ];
    })
    (mkIf cfg.eimzoIntegraion.enable {
      services.e-imzo.enable = mkForce true;
      environment.systemPackages = with pkgs; [
        e-imzo-manager
      ];
    })
    (mkIf cfg.xinuxModuleManager.enable {
      environment.systemPackages = with pkgs; [
        xinux-module-manager
      ];
    })
    (mkIf (cfg.language == "uz_UZ.UTF-8")
      {
        i18n = {
          defaultLocale = "uz_UZ.UTF-8";
        };
      })
    (mkIf (cfg.language == "en_US.UTF-8")
      {
        i18n = {
          defaultLocale = "en_US.UTF-8";
        };
      })
    (mkIf (cfg.language == "ru_RU.UTF-8")
      {
        i18n = {
          defaultLocale = "ru_RU.UTF-8";
        };
      })
  ];
}

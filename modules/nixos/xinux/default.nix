{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.xinux;
in
{
  imports = [
    ./version.nix
  ];

  options.modules.xinux = with types; {
    nixSoftwareCenter.enable = mkOption {
      type = bool;
      default = true;
      description = "Enable Nix Software Center, a graphical software center for Nix";
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
  };
  config = mkMerge [
    (mkIf cfg.nixSoftwareCenter.enable {
      environment.systemPackages = with pkgs; [
        software-center
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
    {
      xinux = {
        osInfo.enable = mkForce true;
      };
    }
  ];
}

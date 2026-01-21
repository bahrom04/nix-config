{
  lib,
  config,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.snowfall-drift.overlays.default
    ];
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Disable if you don't want linux thingies on mac
      allowUnsupportedSystem = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = pkg:
      #   builtins.elem (lib.getName pkg) [
      #     "steam"
      #     "steam-original"
      #     "steam-unwrapped"
      #     "steam-run"
      #   ];
      allowUnfreePredicate = pkg: true;
      # Let the system use fucked up programs
      allowBroken = true;

      permittedInsecurePackages = [
        "googleearth-pro-7.3.6.10201"
      ];
    };
  };

  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings

      experimental-features = "nix-command flakes pipe-operators";
      substituters = [
        "https://cache.xinux.uz/"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" # xinux
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "bahrom"
        "@wheel"
      ];
    };
  };
}

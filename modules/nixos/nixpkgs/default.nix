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
  };

  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings

      experimental-features = "nix-command flakes pipe-operators";
      substituters = [
        "https://cache.nixos.org/"
        "https://cache.xinux.uz/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" # xinux
      ];
      trusted-users = [
        "root"
        "bahrom"
        "@wheel"
      ];
    };
  };
}

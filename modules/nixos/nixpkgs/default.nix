{
  lib,
  config,
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # # Has small chance of kernel modules not being compatible with kernel version.
      inputs.nix-cachyos-kernel.overlays.default
    ];
  };

  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Garbage collector.
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    settings = {
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings

      experimental-features = "nix-command flakes pipe-operators";
      substituters = [
        "https://cache.xinux.uz/" # xinux
        "https://attic.xuyh0120.win/lantian" # cachy
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" 
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
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

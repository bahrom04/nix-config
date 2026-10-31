{
  lib,
  config,
  ...
}:
{
  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    settings = {
      experimental-features = [
        "ca-derivations"
        "recursive-nix"
      ];
      # https://nix.dev/manual/nix/2.35/release-notes/rl-2.35.html#build-performance-improvements
      substituters = [
        "https://cache.xinux.uz?priority=0&compression=zstd&compression-level=3"
        # "https://attic.xuyh0120.win/lantian" # cachy
        # "https://nyx-cache.chaotic.cx/"
        # "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        # "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="
        #   # "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        #   # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "@wheel"
      ];
    };
  };
}

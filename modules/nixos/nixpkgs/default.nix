{
  lib,
  config,
  ...
}:
{
  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Garbage collector.
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    settings = {
      experimental-features = [
        "ca-derivations"
        "recursive-nix"
      ];
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings
      substituters = [
        "https://cache.xinux.uz?priority=10"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://attic.xuyh0120.win/lantian" # cachy
        # "https://nyx-cache.chaotic.cx/"
        # "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        "https://mirrors.ustc.edu.cn/nix-channels/store"
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

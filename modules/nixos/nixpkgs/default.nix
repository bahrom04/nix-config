{
  lib,
  config,
  ...
}:
{
  # nixpkgs = {
  #   overlays = [
  #     # Add overlays your own flake exports (from overlays and pkgs dir):
  #   ];
  # };

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
      substituters = [
        "https://attic.xuyh0120.win/lantian" # cachy
      ];
      trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
      trusted-users = [
        "root"
        "bahrom"
        "@wheel"
      ];
    };
  };
}

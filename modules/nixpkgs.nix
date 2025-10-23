{
  lib,
  config,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages
      inputs.nix-vscode-extensions.overlays.default
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
      experimental-features = "nix-command flakes";
      substituters = ["https://cache.xinux.uz/"];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
      ];
    };
  };
}

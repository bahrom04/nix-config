{
  lib,
  config,
  ...
}: {
  nixpkgs = {
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
      allowUnfreePredicate = (pkg: true);
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
    settings.experimental-features = "nix-command flakes";
  };
}

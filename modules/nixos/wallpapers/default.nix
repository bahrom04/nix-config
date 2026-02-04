{pkgs, ...}: let
  xinux-wallpapers = pkgs.lib.recurseIntoAttrs (pkgs.callPackage ../wallpapers/default.nix {});
in {
  config = {
    environment = {
      systemPackages = with pkgs; [
        xinux-wallpapers
        xinux-wallpapers.xinux-blue-light
        xinux-wallpapers.xinux-blue-dark
        xinux-wallpapers.xinux-orange
      ];
    };
  };
}

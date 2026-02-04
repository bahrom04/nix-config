{pkgs, ...}: let
  xinux-wallpapers = pkgs.lib.recurseIntoAttrs (pkgs.callPackage ../wallpapers/options.nix {});
in {
  config = {
    environment = {
      systemPackages = with pkgs; [
        xinux-wallpapers.xinux-blue-light
        xinux-wallpapers.xinux-blue-dark
        xinux-wallpapers.xinux-orange
      ];
    };
  };
}

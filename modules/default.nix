{
  home = import ./home;
  users = import ./users;
  sops = import ./sops.nix;
  direnv = import ./direnv.nix;
  keyboard = import ./keyboard;
  desktop = import ./desktop.nix;
  nixpkgs = import ./nixpkgs.nix;
  packages = import ./packages.nix;
  gnome_apps = import ./gnome_apps.nix;
  wallpapers = import ./wallpapers.nix;
}

{
  home = import ./home;
  users = import ./users;
  sops = import ./sops.nix;
  services = import ./services;
  direnv = import ./direnv.nix;
  desktop = import ./desktop.nix;
  nixpkgs = import ./nixpkgs.nix;
  packages = import ./packages.nix;
  gnome_apps = import ./gnome_apps.nix;
  wallpapers = import ./wallpapers.nix;
}

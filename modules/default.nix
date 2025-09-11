{
  home = import ./home;
  sops = import ./sops.nix;
  gnome_apps = import ./gnome_apps.nix;
  services = import ./services;
  direnv = import ./direnv.nix;
  desktop = import ./desktop.nix;
  nixpkgs = import ./nixpkgs.nix;
  packages = import ./packages.nix;
}

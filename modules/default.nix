{
  home = import ./home;
  sops = import ./sops.nix;
  gnome = import ./gnome.nix;
  services = import ./services;
  direnv = import ./direnv.nix;
  desktop = import ./desktop.nix;
  nixpkgs = import ./nixpkgs.nix;
  packages = import ./packages.nix;
}

{
  home = import ./home;
  sops = import ./sops.nix;
  services = import ./services;
  direnv = import ./direnv.nix;
  nixpkgs = import ./nixpkgs.nix;
  packages = import ./packages.nix;
}

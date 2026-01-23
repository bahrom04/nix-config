{
  home = import ./home;
  nixos = import ./nixos;
  users = import ./users;
  sops = import ./sops.nix;
  desktop = import ./desktop;
  direnv = import ./direnv.nix;
  keyboard = import ./keyboard;
  nixpkgs = import ./nixpkgs.nix;
  remote-builder = import ./remote-builder.nix;
}

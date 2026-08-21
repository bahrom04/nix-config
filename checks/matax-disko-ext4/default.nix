{
  pkgs,
  inputs,
  ...
}:
let
  diskoLib = inputs.disko.lib;
in
diskoLib.testLib.makeDiskoTest {
  inherit pkgs;
  name = "simple-efi";
  disko-config = ./disko-no-swap.nix;
  extraTestScript = ''
    machine.succeed("mountpoint /");
  '';
}

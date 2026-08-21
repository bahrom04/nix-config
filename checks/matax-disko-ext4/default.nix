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
  disko-config = ../../systems/x86_64-linux/matax/disk-configuration.nix;
  extraTestScript = ''
    machine.succeed("mountpoint /");
  '';
}

{
  inputs,
  config,
  pkgs,
  lib,
  system,
  ...
}: {
  modules.xinux.eimzoIntegraion.enable = false;
  modules.xinux.language = "uz_UZ.UTF-8";
}

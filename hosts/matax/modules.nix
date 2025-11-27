{ inputs
, config
, pkgs
, lib
, system
, ...
}: {
  modules.xinux.eimzoIntegraion.enable = true;
  modules.xinux.language = "uz_UZ.UTF-8";
}

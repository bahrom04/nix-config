{ lib, ... }:
{
  systemd.user.services.e-imzo.wantedBy = lib.mkForce [ ];
  modules.xinux.eimzoIntegraion.enable = true;
  modules.gaming.aagl = true;
  modules.xinux.libreofficePack.enable = false;
  services.gnome.games.enable = true;
  services.flatpak.enable = true;
  modules.xinux.browser = "firefox";
  modules.xinux.xinuxModuleManager.enable = true;
  modules.xinux.binaryCompat.enable = true;
  # modules.shell.direnv = true;
}

{ lib, ... }:
{
  systemd.user.services.e-imzo.wantedBy = lib.mkForce [ ];
  modules.xinux.eimzoIntegraion.enable = false;
  modules.xinux.relago.enable = false;
  modules.shell.rusted-tools = false;
  services.flatpak.enable = false;
  services.gnome.games.enable = false;
  modules.xinux.browser = "firefox";
  modules.xinux.xinuxModuleManager.enable = true;
  modules.xinux.libreofficePack.enable = false;
  modules.xinux.binaryCompat.enable = true;
  # modules.shell.direnv = true;
}

{ lib, ... }:
{
  systemd.user.services.e-imzo.wantedBy = lib.mkForce [ ];
  modules.xinux.eimzoIntegraion.enable = true;
  modules.xinux.relago.enable = false;
  modules.shell.rusted-tools = true;
  services.flatpak.enable = true;
  services.gnome.games.enable = true;
  modules.xinux.browser = "firefox";
  modules.xinux.xinuxModuleManager.enable = true;
  modules.xinux.libreofficePack.enable = false;
  modules.xinux.binaryCompat.enable = true;
  # modules.shell.direnv = true;
}

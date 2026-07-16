{ ... }:
{
  modules.xinux.eimzoIntegraion.enable = true;
  modules.shell.rusted-tools = true;
  services.flatpak.enable = true;
  services.gnome.games.enable = true;
  modules.xinux.browser = "firefox";
  modules.xinux.xinuxModuleManager.enable = true;
  modules.xinux.libreofficePack.enable = false;
  modules.xinux.binaryCompat.enable = true;
  modules.shell.direnv = true;
}

{ lib, ... }:
{
  systemd.user.services.e-imzo.wantedBy = lib.mkForce [ ];
  modules.xinux.eimzoIntegraion.enable = true;
  modules.developer.android.enable = true;
  modules.gaming.aagl = true;
  services.gnome.games.enable = true;
  services.flatpak.enable = true;
  modules.xinux.browser = "zen";
  modules.xinux.xinuxModuleManager.enable = true;
  modules.xinux.binaryCompat.enable = true;
  # modules.shell.direnv = true;
}

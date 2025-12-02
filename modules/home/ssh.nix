{
  pkgs,
  lib,
  ...
}: let
  extraConfig = ''
    IdentityFile ~/.ssh/id_ed25519
    ${(lib.optionalString pkgs.stdenv.isDarwin
      ''
        UseKeychain yes
      '')}
  '';
in {
  config = {
    programs.ssh = {
      # enableDefaultConfig = false;
      enable = true;
      inherit extraConfig;

      matchBlocks = {
        # Uzinfocom
        kolyma-1 = {
          port = 22;
          user = "bahrom04";
          hostname = "ns1.kolyma.uz";
          # Server keep alive
          serverAliveInterval = 30;
          serverAliveCountMax = 3;
          addKeysToAgent = "yes";
        };
      };
    };
  };
}

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
      enable = true;
      inherit extraConfig;
      addKeysToAgent = "yes";

      # Server keep alive
      serverAliveInterval = 30;
      serverAliveCountMax = 3;

      matchBlocks = {
        # Uzinfocom
        kolyma-1 = {
          port = 22;
          user = "bahrom04";
          hostname = "ns1.kolyma.uz";
        };
      };
    };
  };
}

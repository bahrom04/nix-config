{
  pkgs,
  lib,
  ...
}:
{
  config = {
    programs.ssh = {
      enableDefaultConfig = false;
      enable = true;
      matchBlocks = {
        # Uzinfocom
        "*" = {
          user = "bahrom04";
          # Server keep alive
          serverAliveInterval = 30;
          serverAliveCountMax = 3;
          addKeysToAgent = "yes";
          identityFile = "~/.ssh/id_ed25519";
          extraOptions = lib.mkIf pkgs.stdenv.isDarwin {
            UseKeychain = "yes";
          };
        };

        "kolyma-3" = {
          port = 22;
          hostname = "ns3.kolyma.uz";
        };

        # "cloudflare-test" = {
        #   port = 22;
        #   hostname = "ssh.bahrom04.uz";
        #   proxyCommand = "cloudflared access ssh --hostname %h";
        # };
      };
    };
  };
}

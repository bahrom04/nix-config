{...}: {
  config = {
    programs.ssh = {
      enableDefaultConfig = false;
      enable = true;
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

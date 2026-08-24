{
  ...
}:
{
  disko = {
    devices = {
      disk = {
        main = {
          device = "/dev/disk/by-id/ata-WDC_WD10SPZX-22Z10T1_WD-WX21A78237AS";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              BOOT = {
                size = "2G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              SWAP = {
                size = "8G";
                content = {
                  type = "swap";
                  discardPolicy = "both";
                  resumeDevice = true;
                };
              };
              ROOT = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
    tests = {
      extraChecks = ''
        print("$$$$$$$$$$$$$$$$$$$$$$$XINUX$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print(machine.succeed("pwd"))
        print(machine.succeed("vim --version"))
        print(machine.succeed("lslogins bakerdn"))
        print(machine.succeed("cat /etc/nix/nix.conf"))
        print(machine.succeed("alejandra -V"))
        print(machine.succeed("nmcli --version"))
        print("$$$$$$$$$$$$$$$$$$$$$$$XINUX$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
      '';
    };
  };
}

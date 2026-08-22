{
  ...
}:
{
  disko.devices = {
    disk = {
      dell_main = {
        device = "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b448b474a86ac";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            DELL_BOOT = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            DELL_SWAP = {
              size = "25G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
            DELL_ROOT = {
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
}

{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_1TB_S7HDNU0L407583T";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            SWAP = {
              size = "32G";
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
                format = "btrfs";
                mountpoint = "/";
                extraArgs = [ "-f" ];
                mountOptions = [
                  "compress=zstd:3"
                  "discard=async"
                  "noatime"
                ];
              };
            };
          };
        };
      };
    };
  };
}

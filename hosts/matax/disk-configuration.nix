{
  disks ? [
    # 1TB SATA
    "/dev/sda"

    # 2TB HDD
    # this storega now used for windows
    # "/dev/sdb"
  ],
  ...
}: {
  disko.devices = {
    disk = {
      main = {
        device = builtins.elemAt disks 0;
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
                mountOptions = ["umask=0077"];
              };
            };
            SWAP = {
              size = "69G";
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

      # storage = {
      #   device = builtins.elemAt disks 1;
      #   type = "disk";
      #   content = {
      #     type = "gpt";
      #     partitions = {
      #       MEDIA = {
      #         size = "900G";
      #         content = {
      #           type = "filesystem";
      #           format = "ext4";
      #           mountpoint = "/media";
      #         };
      #       };
      #       SERVER = {
      #         size = "100%";
      #         content = {
      #           type = "filesystem";
      #           format = "ext4";
      #           mountpoint = "/srv";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}

# inspiration: https://github.com/wimpysworld/nix-config/blob/main/nixos/skrye/disks.nix
# doc: https://btrfs.readthedocs.io/en/latest/ch-mount-options.html
{
  disks ? [
    # 512 NVME
    "/dev/nvme0n1"
  ],
  ...
}:
{
  disko.devices = {
    disk = {
      main = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              priority = 1;
              size = "1M";
              type = "EF02";
            };
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
              size = "25G";
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
            # ROOT = {
            #   size = "100%";
            #   content = {
            #     type = "btrfs";
            #     format = "btrfs";
            #     extraArgs = [ "-f" ];
            #     subvolumes = {
            #       # intead of @ iʻve used /
            #       "/root" = {
            #         mountpoint = "/";
            #         mountOptions = [
            #           "compress=zstd:3"
            #           "discard=async"
            #           "noatime"
            #         ];
            #       };
            #       "/nix" = {
            #         mountpoint = "/nix";
            #         mountOptions = [
            #           "compress=zstd:3"
            #           "discard=async"
            #           "noatime"
            #         ];
            #       };
            #       "/home" = {
            #         mountpoint = "/home";
            #         mountOptions = [
            #           "compress=zstd:3"
            #           "discard=async"
            #           "noatime"
            #         ];
            #       };
            #       "/swap" = {
            #         mountpoint = "/swap";
            #         mountOptions = [
            #           "noatime"
            #         ];
            #         swapfile.size = "25G";
            #       };
            #     };
            #   };
            # };
          };
        };
      };
    };
  };
}

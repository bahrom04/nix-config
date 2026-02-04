{
  pkgs,
  inputs,
  ...
}: {
  config = {
    # Bootloader.
    boot = {
      loader = {
        # After going back to bootloader, run this: 
        # nixos-rebuild switch --install-bootloader
        systemd-boot.enable = false;
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          devices = ["nodev"];
          useOSProber = true;
          efiSupport = true;
          theme = "${
            (pkgs.fetchFromGitHub {
              owner = "xinux-org";
              repo = "bootloader-theme";
              tag = "v1.0.3";
              hash = "sha256-ipaiJiQ3r2B3si1pFKdp/qykcpaGV+EqXRwl6UkCohs=";
            })
          }/xinux";
        };
      };
      plymouth = {
        enable = true;
        theme = "mac-style";
        themePackages = [inputs.mac-style-plymouth.packages."${pkgs.stdenv.hostPlatform.system}".default];
      };
      consoleLogLevel = 3;
      initrd.systemd.enable = true;
      initrd.verbose = false;
    };
  };
}

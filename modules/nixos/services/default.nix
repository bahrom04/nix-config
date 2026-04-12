{ lib, ... }:
{
  services = {
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    pcscd.enable = true;
    # Enable CUPS to print documents.
    printing.enable = true;
    flatpak.enable = true;
    e-imzo.enable = true;
    opensnitch.enable = false;

    envfs.enable = lib.mkDefault true;

    openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # (not recommended)
        PasswordAuthentication = true;
      };
    };

    zerotierone = {
      enable = false;
      joinNetworks = [
        "743993800f4720b2"
      ];
    };
  };
}

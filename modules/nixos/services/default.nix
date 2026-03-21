{ ... }:
{
  services = {
    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # NVIDIA driver support
    xserver.videoDrivers = [ "nvidia" ];
    pcscd.enable = true;
    # Enable CUPS to print documents.
    printing.enable = true;
    flatpak.enable = true;
    e-imzo.enable = true;
    opensnitch.enable = true;

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

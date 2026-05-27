{ pkgs, ... }:
{
  # Virtualization (also for GNOME Boxes)
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    # virtualbox = {
    #   host.enable = true;
    #   host.enableExtensionPack = true;
    # };
  };
}

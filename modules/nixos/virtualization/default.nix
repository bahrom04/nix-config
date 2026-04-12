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
    # https://wiki.nixos.org/wiki/Podman
    containers.enable = false;
    podman = {
      enable = false;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
    # virtualbox = {
    #   host.enable = true;
    #   host.enableExtensionPack = true;
    # };
  };
}

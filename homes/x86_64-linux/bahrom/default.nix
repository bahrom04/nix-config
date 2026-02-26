{ ... }:
{
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "25.11";
    username = "bahrom";
    enableNixpkgsReleaseCheck = false;
    keyboard = {
      layout = "uz";
      variant = "latin";
    };
  };

  # Let's enable home-manager
  programs.home-manager.enable = true;
}

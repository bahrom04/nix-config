{pkgs, ...}: {
  config = {
    fonts.packages = with pkgs; [
      corefonts
    ];
  };
}

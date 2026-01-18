{inputs, ...}: {
  imports = [
    inputs.uzbek-keyboard.nixosModules.module
  ];

  # services.xserver = {
  #   enable = true;

  #   # Configure keymap in X11
  #   xkb = {
  #     extraLayouts.uz = {
  #       description = "Uzbek (Oʻzbekiston)";
  #       languages = ["eng" "uzb"];
  #       symbolsFile = ./uz;
  #     };
  #     layout = "uz,us";
  #     variant = "latin";
  #   };
  # };

  services.xserver.xkb.uz-enhanced.enable = true;
}

{inputs, ...}: let
  xkbPath = ./xkb;
in {
  services.xserver = {
    enable = true;

    xkb = {
      variant = "latin";
      layout = "uz,uz(latin),us,ru";

      extraLayouts = {
        uz = {
          description = "Uzbek";
          languages = ["uzb"];
          symbolsFile = "${xkbPath}/uz";
        };
        uz-us = {
          description = "Uzbek (US)";
          languages = ["uzb"];
          symbolsFile = "${xkbPath}/uz_us";
        };
        uz-2023 = {
          description = "Uzbek (2023)";
          languages = ["uzb"];
          symbolsFile = "${xkbPath}/uz_2023";
        };
        uz-cyrillic = {
          description = "Uzbek (Cyrillic)";
          languages = ["uzb"];
          symbolsFile = "${xkbPath}/uz_cyrillic";
        };
      };
    };
  };

  # services.xserver.xkb.uz-enhanced.enable = true;
}

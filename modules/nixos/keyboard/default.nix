{ inputs, ... }:
let
  xkbPath = ./xkb;
in
{
  services.xserver = {
    enable = true;

    xkb = {
      # Switch between layouts using Alt+Shift
      options = "grp:alt_shift_toggle,lv3:ralt_switch";
      variant = "latin";
      layout = "uz,us,ru";

      extraLayouts = {
        uz = {
          description = "Uzbek";
          languages = [ "uzb" ];
          symbolsFile = "${inputs.uz-xkb}/uz_compat";
        };
        uz-us = {
          description = "Uzbek (US)";
          languages = [ "uzb" ];
          symbolsFile = "${xkbPath}/uz_us";
        };
        uz-2023 = {
          description = "Uzbek (2023)";
          languages = [ "uzb" ];
          symbolsFile = "${xkbPath}/uz_2023";
        };
        uz-cyrillic = {
          description = "Uzbek (Cyrillic)";
          languages = [ "uzb" ];
          symbolsFile = "${xkbPath}/uz_cyrillic";
        };
      };
    };
  };

  # services.xserver.xkb.uz-enhanced.enable = true;
}

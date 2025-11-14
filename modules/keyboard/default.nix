{...}: {
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb = {
      extraLayouts.uz = {
        description = "Uzbek (Oʻzbekiston)";
        languages = ["eng" "uzb"];
        # symbolsFile = "${pkgs.fetchFromGitHub {
        #   owner = "bahrom04";
        #   repo = "uzbek-latin-keyboard";
        #   rev = "main";
        #   hash = "sha256-29UHkTc+k+IXt491zKows2Y4g1Ba6XdjlO2wnTMJFQM=";
        # }}/uz";
        symbolsFile = ./uz;
      };
      layout = "uz,us";
      variant = "latin";
    };
  };
}

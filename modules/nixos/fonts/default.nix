{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts
    vista-fonts-chs
    # General Noto fonts
    noto-fonts
    noto-fonts-color-emoji
    # CJK specific fonts (Sans and Serif)
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    # An alternative popular Chinese font
    wqy_zenhei
    # Other potential CJK fonts
    mplus-outline-fonts.osdnRelease

  ];
}

{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # An alternative popular Chinese font
    wqy_zenhei

    corefonts
    vista-fonts-chs
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nerd-fonts.jetbrains-mono
    mplus-outline-fonts.osdnRelease
    liberation_ttf
    fira-code
    fira-code-symbols
  ];
}

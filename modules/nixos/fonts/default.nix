{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      # An alternative popular Chinese font
      wqy_zenhei
      ubuntu-classic
      corefonts
      carlito
      vista-fonts
      vista-fonts-chs
      font-bh-ttf
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.jetbrains-mono
      mplus-outline-fonts.osdnRelease
      fira-code
      fira-code-symbols
      hermit
      source-code-pro
      terminus_font
      font-awesome
      font-awesome_4
      hack-font
      noto-fonts
      cantarell-fonts
      powerline-fonts
      roboto
      roboto-slab
      montserrat
      inter
      lato
      eb-garamond
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      oswald
      rubik
    ];
  };
}

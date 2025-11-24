{
  lib,
  stdenv,
}: let
  mkNixBackground = {
    name,
    src,
    description,
    license ? lib.licenses.free,
  }: let
    pkg = stdenv.mkDerivation {
      inherit name src;

      dontUnpack = true;

      installPhase = ''
                runHook preInstall

                # GNOME
                mkdir -p $out/share/backgrounds/nixos
                ln -s $src $out/share/backgrounds/nixos/${baseNameOf src}

                mkdir -p $out/share/gnome-background-properties/
                cat <<EOF > $out/share/gnome-background-properties/${name}.xml
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
        <wallpapers>
          <wallpaper deleted="false">
            <name>${name}</name>
            <filename>${src}</filename>
            <options>zoom</options>
            <shade_type>solid</shade_type>
            <pcolor>#ffffff</pcolor>
            <scolor>#000000</scolor>
          </wallpaper>
        </wallpapers>
        EOF

                # TODO: is this path still needed?
                mkdir -p $out/share/artwork/gnome
                ln -s $src $out/share/artwork/gnome/${baseNameOf src}

                # KDE
                mkdir -p $out/share/wallpapers/${name}/contents/images
                ln -s $src $out/share/wallpapers/${name}/contents/images/${baseNameOf src}
                cat >>$out/share/wallpapers/${name}/metadata.desktop <<_EOF
        [Desktop Entry]
        Name=${name}
        X-KDE-PluginInfo-Name=${name}
        _EOF

                runHook postInstall
      '';

      passthru = {
        gnomeFilePath = "${pkg}/share/backgrounds/nixos/${baseNameOf src}";
        kdeFilePath = "${pkg}/share/wallpapers/${name}/contents/images/${baseNameOf src}";
      };

      meta = with lib; {
        inherit description license;
        homepage = "https://github.com/NixOS/nixos-artwork";
        platforms = platforms.all;
      };
    };
  in
    pkg;
in {
  xinux-blue-light = mkNixBackground {
    name = "xinux-blue-light";
    description = "xinux-blue-light";
    src = ../../.github/assets/wallpapers/xinux-l.jpg;
    license = lib.licenses.cc-by-sa-40;
  };

  xinux-blue-dark = mkNixBackground {
    name = "xinux-blue-dark";
    description = "xinux-blue-dark";
    src = ../../.github/assets/wallpapers/xinux-d.jpg;
    license = lib.licenses.cc-by-sa-40;
  };

  xinux-orange = mkNixBackground {
    name = "xinux-orange";
    description = "xinux-orange";
    src = ../../.github/assets/wallpapers/xinux-orange.jpg;
    license = lib.licenses.cc-by-sa-40;
  };
}

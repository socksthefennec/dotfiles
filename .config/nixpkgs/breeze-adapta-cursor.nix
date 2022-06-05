with import <nixpkgs> { };

stdenv.mkDerivation {
  name = "Breeze-Adapta-Cursor";

  src = fetchFromGitHub {
    owner = "mustafaozhan";
    repo = "Breeze-Adapta-Cursor";
    rev = "72ffeffb12b0dae77d6ffff2654f80f477231e69";
    sha256 = "1wh3c98j59z07qbx7bkzh89bia40lvlal2gb2ldnrfxv8hc6jdpq";
  };

  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup
    mkdir -p $out/share/icons/Breeze-Adapta-Cursor
    cd $src
    cp -r cursors cursor.theme index.theme $out/share/icons/Breeze-Adapta-Cursor
  '';

  meta = with lib; {
    description = "Popular Breeze Cursor modified for Adapta theme";
    homepage = "https://github.com/mustafaozhan/Breeze-Adapta-Cursor";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}

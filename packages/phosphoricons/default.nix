{
  lib,
  stdenvNoCC,
  fetchzip,
}:

#TODO upstream to nixpkgs
stdenvNoCC.mkDerivation rec {
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  doCheck = false;
  dontFixup = true;

  pname = "phosphoricons";
  version = "2.0.0";

  src = fetchzip {
    url = "https://github.com/phosphor-icons/homepage/releases/download/v${version}/phosphor-icons.zip";
    sha256 = "sha256-IfgGO56N8eO2MB8H16+KvkpHiHfs6SOEittYEnaVIfY=";
  };

  installPhase = ''
    runHook preInstall

    # these come up in some source trees, but are never useful to us
    find -iname __MACOSX -type d -print0 | xargs -0 rm -rf
    find -type f,l

    find -iname '*.ttc' -print0 | xargs -0 -r install -v -m644 --target $out/share/fonts/truetype/ -D
    find -iname '*.ttf' -print0 | xargs -0 -r install -v -m644 --target $out/share/fonts/truetype/ -D
    find -iname '*.otf' -print0 | xargs -0 -r install -v -m644 --target $out/share/fonts/opentype/ -D
    find -iname '*.bdf' -print0 | xargs -0 -r install -v -m644 --target $out/share/fonts/misc/ -D
    find -iname '*.otb' -print0 | xargs -0 -r install -v -m644 --target $out/share/fonts/misc/ -D
    find -iname '*.psf' -print0 | xargs -0 -r install -v -m644 --target $out/share/consolefonts/ -D

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://phosphoricons.com/";
    description = "A flexible icon family for interfaces, diagrams, presentations — whatever, really.";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ rektdeckard ];
  };
}

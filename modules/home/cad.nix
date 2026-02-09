{
  #meta.doc = builtins.toFile "doc.md" "A suite for CAD work.";

  services.flatpak.packages = [
    {
      origin = "flathub-beta";
      appId = "org.freecad.FreeCAD";
    }
    "io.github.ferraridamiano.ConverterNOW"
  ];
}

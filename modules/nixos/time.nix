{
  #meta.doc = builtins.toFile "doc.md" "Configures the german time zone on your system.";

  time.timeZone = "Europe/Berlin";
}

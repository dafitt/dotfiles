{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the locate service.";

  services.locate.enable = true;
}

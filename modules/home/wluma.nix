{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures wluma.";

  services.wluma.enable = true;
}

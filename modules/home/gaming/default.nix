{
  #meta.doc = builtins.toFile "doc.md" "A suite for gaming on your environment.";

  imports = [ ./steam.nix ];
}

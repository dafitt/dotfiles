{
  #meta.doc = builtins.toFile "doc.md" "Personal settings.";

  programs.git.settings.user = {
    name = "dafitt";
    email = "dafitt@posteo.me";
  };
}

{
  #meta.doc = builtins.toFile "doc.md" "Enables AppImage support on your system.";

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}

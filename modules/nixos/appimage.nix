{
  meta.doc = "Enables AppImage support on your system.";

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}

{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite of applications for managing music and audio files.";

  home.packages = with pkgs; [
    amberol
    blanket
    deezer-enhanced
    eartag
    mousai
    shortwave
  ];
}

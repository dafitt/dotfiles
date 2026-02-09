{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite for reading comics/mangas/webtoons.";

  home.packages = with pkgs; [
    komikku
    comic-mandown
  ];
}

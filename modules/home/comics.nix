{ pkgs, ... }:
{
  meta.doc = "A suite for reading comics/mangas/webtoons.";

  home.packages = with pkgs; [
    komikku
    comic-mandown
  ];
}

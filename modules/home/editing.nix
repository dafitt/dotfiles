{ pkgs, ... }:
{
  meta.doc = "A suite for editing media files, including video and audio editing tools.";

  home.packages = with pkgs; [
    curtail
    footage
    identity
    metadata-cleaner
    shotcut
    tenacity
    video-trimmer
  ];
}

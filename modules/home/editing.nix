{ pkgs, ... }:
{
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

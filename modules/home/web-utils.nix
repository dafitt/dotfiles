{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite of additional web applications and tools.";

  home.packages = with pkgs; [
    fragments
    collision
  ];

  services.flatpak.packages = [
    "io.freetubeapp.FreeTube" # An Open Source YouTube app for privacy
    "xyz.ketok.Speedtest" # Measure your internet connection speed
  ];
}

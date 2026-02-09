{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite for ricing your environment.";

  imports = [
    ./cava.nix
  ];

  home.packages = with pkgs; [
    asciiquarium
    cava
    cbonsai
    cowsay
    fortune
    lolcat
    peaclock
    pipes
  ];
}

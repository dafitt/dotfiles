{ pkgs, ... }:
{
  meta.doc = "A suite for ricing your environment.";

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

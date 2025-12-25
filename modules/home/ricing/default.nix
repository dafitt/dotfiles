{ pkgs, ... }:
{
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

{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Configures the coreutils on your system.";

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
  ];
}

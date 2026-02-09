{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures an archive manager.";

  home.packages = with pkgs; [
    file-roller
  ];
}

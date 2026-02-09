{ pkgs, ... }:
{
  meta.doc = "Installs and configures an archive manager.";

  home.packages = with pkgs; [
    file-roller
  ];
}

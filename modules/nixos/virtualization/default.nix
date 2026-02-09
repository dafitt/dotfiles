{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite for virtualization on your system.";

  environment.systemPackages = with pkgs; [
    gparted
  ];
}

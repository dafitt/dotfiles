{ pkgs, ... }:
{
  meta.doc = "A suite for virtualization on your system.";

  environment.systemPackages = with pkgs; [
    gparted
  ];
}

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bashmount
    gnome-disk-utility
    gparted
    gptfdisk
    hdparm
    parted
    tparted
  ];
}

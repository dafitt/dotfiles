{ pkgs, ... }:
{
  systemd.tmpfiles.rules = [
    "d /mnt 0755 root root"
  ];

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

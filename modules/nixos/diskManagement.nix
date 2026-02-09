{ pkgs, ... }:
{
  meta.doc = "A suite for managing disks on the system.";

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

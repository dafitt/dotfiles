{
  config,
  lib,
  pkgs,
  ...
}:

{
  users.users.root = {
    packages = with pkgs; [
      bashmount # easy mounting
      gparted # graphical disk partitioning tool
      gptfdisk # gdisk, cgdisk, sgdisk
      hdparm # get/set ATA/SATA drive parameters
      micro # easy to use texteditor
    ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  zfs = builtins.hasAttr "zfs" config.boot.supportedFilesystems;
in
{
  # <https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels>
  # pkgs.linuxPackages_6_6;
  # pkgs.linuxPackages; # LTS kernel
  # pkgs.linuxPackages_latest;
  # pkgs.linuxPackages_zen;
  boot.kernelPackages = mkDefault (if zfs then pkgs.linuxPackages else pkgs.linuxPackages_latest);

  services.system76-scheduler.enable = true;
}

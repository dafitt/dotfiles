{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.kernel;

  zfs = builtins.hasAttr "zfs" config.boot.supportedFilesystems;
in
{
  options.dafitt.kernel = with types; {
    enable = mkBoolOpt true "Whether or not to change the linux kernel.";
    package = mkOption {
      type = raw;
      description = "Which linux kernel package to use.";
      default =
        if zfs then config.boot.zfs.package.latestCompatibleLinuxPackages else pkgs.linuxPackages_latest;
      example = ''
        <https://wiki.nixos.org/wiki/Linux_kernel#List_available_kernels>
        pkgs.linuxPackages_5_10;
        pkgs.linuxPackages;
        pkgs.linuxPackages_latest;
        pkgs.linuxPackages_zen;
        config.boot.zfs.package.latestCompatibleLinuxPackages;
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = cfg.package;
  };
}

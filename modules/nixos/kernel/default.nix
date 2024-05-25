{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.kernel;
in
{
  options.dafitt.kernel = {
    enable = mkBoolOpt true "Whether or not to manage the linux kernel.";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = mkDefault pkgs.linuxPackages_latest;
  };
}

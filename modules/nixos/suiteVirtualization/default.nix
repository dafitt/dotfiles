{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteVirtualization;
in
{
  options.dafitt.suiteVirtualization = with types; {
    enable = mkEnableOption "the Virtualization suite";
  };

  config = mkIf cfg.enable { };
}

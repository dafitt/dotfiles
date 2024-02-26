{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.fwupd;
in
{
  options.custom.features.fwupd = with types; {
    enable = mkBoolOpt false "Enable fwupd, a tool to update firmware on Linux";
  };

  config = mkIf cfg.enable {
    # To update various firmware see https://nixos.wiki/wiki/Fwupd
    services.fwupd.enable = true;
  };
}

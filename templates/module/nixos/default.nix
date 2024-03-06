{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.module;
in
{
  options.custom.module = with types; {
    enable = mkBoolOpt false "Enable module";
  };

  config = mkIf cfg.enable { };
}

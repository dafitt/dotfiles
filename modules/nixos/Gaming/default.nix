{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming;
in
{
  options.dafitt.Gaming = with types; {
    enableSuite = mkBoolOpt false "Whether to enable the Gaming suite";
  };

  config = mkIf cfg.enableSuite {
    environment.systemPackages = with pkgs; [
    ];
  };
}

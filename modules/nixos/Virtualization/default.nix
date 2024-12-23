{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Virtualization;
in
{
  options.dafitt.Virtualization = with types; {
    enableSuite = mkBoolOpt false "Whether to enable the Virtualization suite.";
  };

  config = mkIf cfg.enableSuite {
    environment.systemPackages = with pkgs; [
    ];
  };
}

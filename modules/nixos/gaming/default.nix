{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming;
in
{
  options.dafitt.gaming = with types; {
    enableSuite = mkBoolOpt false "Enable the gaming suite";
  };

  config = mkIf cfg.enableSuite {
    environment.systemPackages = with pkgs; [
    ];
  };
}

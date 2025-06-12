{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.uutils;
in
{
  options.dafitt.uutils = with types; {
    enable = mkEnableOption "uutils-coreutils";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      uutils-coreutils-noprefix
    ];
  };
}

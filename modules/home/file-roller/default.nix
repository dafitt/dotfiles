{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.file-roller;
in
{
  options.dafitt.file-roller = with types; {
    enable = mkEnableOption "the file-roller archive manager";

  };

  config = mkIf cfg.enable {
    # GNOME's archive manager
    home.packages = with pkgs; [ file-roller ];
  };
}

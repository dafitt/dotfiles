{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.file-roller;
in
{
  options.dafitt.file-roller = with types; {
    enable = mkBoolOpt true "Whether to enable the file-roller archive manager.";
    defaultApplication = mkBoolOpt true "Set file-roller as the default application for its mimetypes.";

  };

  config = mkIf cfg.enable {
    # GNOME's archive manager
    home.packages = with pkgs; [ file-roller ];
  };
}

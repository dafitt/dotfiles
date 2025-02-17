{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.home-manager;
in
{
  options.dafitt.home-manager = with types; {
    enable = mkEnableOption "home-manager configuration";
  };

  config = mkIf cfg.enable {
    home-manager = {
      backupFileExtension = "hm-old"; # Move existing files rather than failing
    };
  };
}

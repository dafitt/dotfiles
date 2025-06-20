{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.sudo;
in
{
  options.dafitt.sudo = with types; {
    enable = mkEnableOption "sudo configuration";
  };

  config = mkIf cfg.enable {
    security = {
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        extraConfig = ''
          Defaults env_keep += "EDITOR PATH DISPLAY"
        '';
      };
    };
  };
}

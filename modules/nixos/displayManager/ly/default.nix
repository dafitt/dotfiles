{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.displayManager.ly;
in
{
  options.dafitt.displayManager.ly = with types; {
    enable = mkEnableOption "ly as the login/display manager";
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}

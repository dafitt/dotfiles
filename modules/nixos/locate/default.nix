{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.locate;
in
{
  options.dafitt.locate = with types; {
    enable = mkEnableOption "locate, a utility to list files in databases that match a pattern";
  };

  config = mkIf cfg.enable {
    services.locate.enable = true;
  };
}

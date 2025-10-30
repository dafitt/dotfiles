{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.tailscale;
  osCfg = osConfig.dafitt.tailscale or null;
in
{
  options.dafitt.tailscale = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable tailscale.";
  };

  config = mkIf cfg.enable {
    services.tailscale-systray.enable = true;
  };
}

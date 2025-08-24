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
  cfg = config.dafitt.suiteVirtualization;
  osCfg = osConfig.dafitt.suiteVirtualization or null;
in
{
  options.dafitt.suiteVirtualization = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Virtualization suite.";
  };

  config = mkIf cfg.enable {
    dafitt = {
      quickemu.enable = true;
    };

    home.packages = with pkgs; [
      gparted # Graphical disk partitioning tool
    ];
  };
}

{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming.gamemode;
in
{
  options.dafitt.gaming.gamemode = with types; {
    enable = mkBoolOpt config.dafitt.gaming.enableSuite "Enable the gamemode command.";
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "on";
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
      };
    };
  };
}

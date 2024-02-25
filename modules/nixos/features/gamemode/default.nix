{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.features.gamemode;
in
{
  options.features.gamemode = with types; {
    enable = mkBoolOpt false "Enable gamemode, a program to optimize system performance for games";
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

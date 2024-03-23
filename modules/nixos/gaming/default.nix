{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming;
in
{
  options.custom.gaming = with types; {
    enableSuite = mkBoolOpt false "Enable the gaming suite";
  };

  config = mkIf cfg.enableSuite {
    environment.systemPackages = with pkgs; [
    ];

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
    programs.gamescope = {
      enable = true;
      capSysNice = true;
      env = {
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        WINE_FULLSCREEN_FSR = "1";
        WLR_RENDERER = "vulkan";
      };
      args = [ "--hdr-enabled" ];
    };
  };
}

{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteGaming;
in
{
  options.dafitt.suiteGaming = with types; {
    enable = mkEnableOption "the Gaming suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      piper # GUI for ratbagd
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
      args = [ ];
    };

    services.ratbagd.enable = true; # a DBus daemon to configure gaming mice
  };
}

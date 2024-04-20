{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gaming.gamescope;
in
{
  options.dafitt.gaming.gamescope = with types; {
    enable = mkBoolOpt config.dafitt.gaming.enableSuite "Enable the gamescope command";
  };

  config = mkIf cfg.enable {
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

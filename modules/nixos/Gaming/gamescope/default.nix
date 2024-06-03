{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Gaming.gamescope;
in
{
  options.dafitt.Gaming.gamescope = with types; {
    enable = mkBoolOpt config.dafitt.Gaming.enableSuite "Enable the gamescope command.";
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

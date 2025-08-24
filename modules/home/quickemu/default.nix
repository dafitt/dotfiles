{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.quickemu;
in
{
  # https://github.com/quickemu-project/quickemu/wiki/

  options.dafitt.quickemu = with types; {
    enable = mkEnableOption "quickemu";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      quickemu
      quickgui
    ];

    wayland.windowManager.hyprland.settings = {
      windowrule = [ "float, class:quickgui" ];
    };
  };
}

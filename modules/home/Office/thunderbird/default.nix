{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Office.thunderbird;
in
{
  options.dafitt.Office.thunderbird = with types; {
    enable = mkBoolOpt config.dafitt.Office.enableSuite "Enable thunderbird.";
  };

  config = mkIf cfg.enable {
    # A full-featured e-mail client
    # https://www.thunderbird.net/
    programs.thunderbird = {
      enable = true;
      profiles."main".isDefault = true;
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, M, exec, ${pkgs.thunderbird}/bin/thunderbird" ];
    };
  };
}

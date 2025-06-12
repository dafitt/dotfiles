{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins;
in
{
  options.dafitt.hyprland.plugins = with types; {
    enable = mkEnableOption "plugins alltogether";
  };

  config = mkIf cfg.enable {
    dafitt.hyprland.plugins = {
      hyprexpo.enable = true;
    };

    assertions = [{
      assertion = (count (option: option.enable) [ cfg.hyprsplit cfg.hyprnome ]) < 2;
      message = "Only one of [ hyprsplit hyprnome ] in dafitt.hyprland.plugins can be enabled at a time. Because they alter keybindings in a different way.";
    }];
  };
}

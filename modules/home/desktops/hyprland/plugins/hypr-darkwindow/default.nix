{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hypr-darkwindow;
in
{
  options.dafitt.desktops.hyprland.plugins.hypr-darkwindow = with types; {
    enable = mkBoolOpt false "Whether to enable the hypr-darkwindow hyprland plugin.";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/micha4w/Hypr-DarkWindow
      plugins = with pkgs; [ inputs.hypr-darkwindow.packages.${system}.Hypr-DarkWindow ];

      settings.bind = [ "SUPER, O, invertactivewindow, " ];
    };
  };
}

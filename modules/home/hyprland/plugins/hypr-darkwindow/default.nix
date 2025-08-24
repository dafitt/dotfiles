{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.plugins.hypr-darkwindow;
in
{
  options.dafitt.hyprland.plugins.hypr-darkwindow = with types; {
    enable = mkEnableOption "hypr-darkwindow";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/micha4w/Hypr-DarkWindow
      #TODO upstream: add to nixpkgs
      plugins = with pkgs; [ inputs.hypr-darkwindow.packages.${system}.Hypr-DarkWindow ];

      settings.bind = [ "SUPER, O, invertactivewindow, " ];
    };
  };
}

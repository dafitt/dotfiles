{
  config,
  lib,
  perSystem,
  ...
}:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins.hypr-darkwindow;
in
{
  options.dafitt.desktopEnvironment-hyprland.plugins.hypr-darkwindow = {
    enable = mkEnableOption "hypr-darkwindow";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/micha4w/Hypr-DarkWindow
      #TODO upstream: add to nixpkgs
      plugins = [ perSystem.hypr-darkwindow.Hypr-DarkWindow ];

      settings.bind = [ "Super, O, invertactivewindow, " ];
    };
  };
}

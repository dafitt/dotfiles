{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.gaming.steam;
in
{
  options.custom.gaming.steam = with types; {
    enable = mkBoolOpt config.custom.gaming.enableSuite "Enable steam";
  };

  config = mkIf cfg.enable {
    services.flatpak.packages = [
      "com.valvesoftware.Steam"
    ];

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "bordercolor rgb(1887d8), class:steam"
      "float, class:steam, title:(Friends List)|(Settings)"
    ];
  };
}

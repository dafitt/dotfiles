{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.plugins.hyprspace;
in
{
  options.dafitt.desktops.hyprland.plugins.hyprspace = with types; {
    enable = mkBoolOpt false "Enable hyprspace hyprland plugin";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # https://github.com/KZDKM/Hyprspace
      plugins = with pkgs; [ inputs.hyprspace.packages.${system}.hyprspace ];

      settings.bind = [ "SUPER, grave, overview:toggle, " ];

      settings.plugin.overview = { };

      extraConfig = ''
      '';
    };
  };
}

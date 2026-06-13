{ lib, pkgs, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures a calculator application.";

  home.packages = with pkgs; [ gnome-calculator ];

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          "XF86Calculator"
          (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.gnome-calculator}")'')
          { description = "Open calculator"; }
        ];
      }
    ];
    window_rule = [
      {
        match.class = "org.gnome.Calculator";
        float = true;
        keep_aspect_ratio = true;
      }
    ];
  };
  programs.niri.settings = {
    binds."XF86Calculator".action.spawn-sh = "uwsm app -- ${getExe pkgs.gnome-calculator}";
    window-rules = [
      {
        matches = [ { app-id = "org.gnome.Calculator"; } ];
        open-floating = true;
      }
    ];
  };
}

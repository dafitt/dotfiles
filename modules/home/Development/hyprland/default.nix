{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.hyprland;
in
{
  options.dafitt.Development.hyprland = with types; {
    enable = mkBoolOpt config.dafitt.Development.enableSuite "Whether to enable hyprland development.";
  };

  config = mkIf cfg.enable {
    # https://wiki.hyprland.org/Configuring/Variables/#debug
    wayland.windowManager.hyprland.settings.debug = {
      # current log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log
      # last log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 2 | tail -n 1)/hyprland.log
      disable_logs = false;
    };
  };
}

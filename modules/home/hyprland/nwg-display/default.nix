# https://github.com/nwg-piotr/nwg-displays
{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.nwg-displays;
in
{
  options.dafitt.hyprland.nwg-displays = with types; {
    enable = mkBoolOpt config.dafitt.hyprland.enable ''
      Enable nwg-displays, to adjust the screen layout and resolution.
      Declarative configuration through `config.dafitt.hyprland.monitors` overrides specific monitor configuraition!
    '';
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wlr-randr
      nwg-displays
    ];

    home.activation = {
      touchNwgdisplaysFiles = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        touch -a $HOME/.config/hypr/monitors.conf
        touch -a $HOME/.config/hypr/workspaces.conf
      '';
    };

    wayland.windowManager.hyprland.settings = {
      source = [
        "~/.config/hypr/monitors.conf"
        "~/.config/hypr/workspaces.conf"
      ];
    };
  };
}

{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.hyprland.cliphist;
in
{
  options.custom.desktops.hyprland.cliphist = with types; {
    enable = mkBoolOpt config.custom.desktops.hyprland.enable "Enable cliphist for hyprland";
  };

  config = mkIf cfg.enable {
    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist = {
      enable = true;
      #systemdTarget =
    };

    home.packages = with pkgs; [
      pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland
    ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER_ALT, V, exec, ${pkgs.kitty}/bin/kitty --class=clipboard -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'"
      ];
      exec-once = [
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${config.services.cliphist.package}/bin/cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${config.services.cliphist.package}/bin/cliphist store --max-items 10" # listen for clipboard changes on your keyboard and write it to the history
      ];
      windowrulev2 = [
        "float, class:clipboard"
        "size 640 360, class:clipboard"
        "center, class:clipboard"
      ];
    };

    systemd.user.services."cliphist-wipe" = {
      Unit.Description = "deleting clipboard history";
      Service = {
        Type = "oneshot";
        ExecStart = "${config.services.cliphist.package}/bin/cliphist wipe";
      };
    };
  };
}

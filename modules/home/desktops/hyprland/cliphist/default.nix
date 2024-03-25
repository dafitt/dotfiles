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
    home.packages = with pkgs; [
      pkgs.wl-clipboard # Command-line copy/paste utilities for Wayland
    ];

    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist = {
      enable = true;
      systemdTarget = "hyprland-session.target";
    };

    # simple cliphist selector
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER_ALT, V, exec, ${pkgs.kitty}/bin/kitty --class=clipboard -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'"
      ];
      windowrulev2 = [
        "float, class:clipboard"
        "size 640 360, class:clipboard"
        "center, class:clipboard"
      ];
    };

    # in addition to https://github.com/nix-community/home-manager/blob/master/modules/services/cliphist.nix
    systemd.user.services.cliphist.Service = {
      ExecStop = "${config.services.cliphist.package}/bin/cliphist wipe";
    };
  };
}

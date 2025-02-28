{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.cliphist;
in
{
  options.dafitt.hyprland.cliphist = with types; {
    enable = mkEnableOption "cliphist for hyprland";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      pkgs.wl-clipboard-rs # Command-line copy/paste utilities for Wayland
    ];

    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist = {
      enable = true;
      systemdTargets = "wayland-session@Hyprland.target";
    };

    # simple cliphist selector
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER_ALT, V, exec, uwsm app -- ${pkgs.kitty}/bin/kitty --class=clipboard -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'"
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

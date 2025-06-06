{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.clipboardManagers.cliphist;
in
{
  options.dafitt.clipboardManagers.cliphist = with types; {
    enable = mkEnableOption "clipboard manager 'cliphist'";

    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard-rs # Command-line copy/paste utilities for Wayland
    ];

    # Wayland clipboard manager
    # https://github.com/sentriz/cliphist
    services.cliphist = {
      enable = true;
      systemdTargets = [ "wayland-session@Hyprland.target" ];
    };

    # simple cliphist selector
    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [
        "SUPER_ALT, V, exec, uwsm app -- ${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'"
      ];
      windowrule = [
        "float, class:(cliphist)"
        "size 622 652, class:(cliphist)"
        "center, class:(cliphist)"
      ];
    };

    # in addition to https://github.com/nix-community/home-manager/blob/master/modules/services/cliphist.nix
    systemd.user.services.cliphist.Service = {
      ExecStop = "${config.services.cliphist.package}/bin/cliphist wipe";
    };
  };
}

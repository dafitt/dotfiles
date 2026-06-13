{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.clipboardManager-cliphist;
in
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the Cliphist clipboard manager.
  #  <https://github.com/sentriz/cliphist>
  #'';

  options.dafitt.clipboardManager-cliphist = with types; {
    setAsDefaultClipboardManager = mkEnableOption "making it the default clipboard manager";
  };

  config = {
    home.packages = with pkgs; [
      wl-clipboard-rs
    ];

    services.cliphist.enable = true;

    # in addition to https://github.com/nix-community/home-manager/blob/master/modules/services/cliphist.nix
    systemd.user.services.cliphist.Service = {
      ExecStop = "${config.services.cliphist.package}/bin/cliphist wipe";
    };

    # simple cliphist selector
    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultClipboardManager [
        {
          _args = [
            "SUPER + ALT + V"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'")'')
            { description = "Open clipboard"; }
          ];
        }
      ];
      window_rule = [
        {
          match.class = "cliphist$";
          no_screen_share = true;
          float = true;
          size = "{622, 652}";
          center = true;
        }
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+V" = mkIf cfg.setAsDefaultClipboardManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'";
      };
      window-rules = [
        {
          matches = [
            { app-id = "cliphist"; }
          ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}

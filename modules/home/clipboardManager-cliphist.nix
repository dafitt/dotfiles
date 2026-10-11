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
    programs.umbriel.settings = {
      keybinds."Mod+Alt+V" = mkIf cfg.setAsDefaultClipboardManager {
        action = "spawn:${getExe pkgs.kitty} --class=cliphist -e sh -c '${config.services.cliphist.package}/bin/cliphist list | ${pkgs.fzf}/bin/fzf | ${config.services.cliphist.package}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy'";
        repeat = false;
      };
      window_rule = [
        {
          match.app_id = "cliphist";
          default_floating = true;
        }
      ];
    };
  };
}

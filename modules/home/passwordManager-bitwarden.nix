{
  config,
  lib,
  pkgs,
  perSystem,
  ...
}:
with lib;
let
  cfg = config.dafitt.passwordManager-bitwarden;
in
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures Bitwarden password manager.";

  options.dafitt.passwordManager-bitwarden = with types; {
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = {
    home.packages = with pkgs; [ bitwarden-desktop ];

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      perSystem.nur.repos.rycee.firefox-addons.bitwarden
    ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultPasswordManager [
        {
          _args = [
            "SUPER + ALT + Period"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs.bitwarden-desktop}")'')
            { description = "Open Bitwarden"; }
          ];
        }
      ];
      window_rule = [
        {
          match.class = "Bitwarden";
          no_screen_share = true;
        }
        {
          match.class = "Bitwarden";
          match.title = "Bitwarden";
          float = true;
        }
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+Period" = mkIf cfg.setAsDefaultPasswordManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.bitwarden-desktop}";
      };
      window-rules = [
        {
          matches = [ { app-id = "Bitwarden"; } ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}

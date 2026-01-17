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
        "Super&Alt, PERIOD, exec, uwsm app -- ${getExe pkgs.bitwarden-desktop}"
      ];
      windowrule = [
        "match:class Bitwarden, no_screen_share on"
        "match:class Bitwarden, match:title Bitwarden, float on"
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

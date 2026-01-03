{
  config,
  lib,
  pkgs,
  perSystem,
  ...
}:
with lib;
let
  cfg = config.dafitt.passwordManager-_1password;
in
{
  options.dafitt.passwordManager-_1password = with types; {
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = {
    # Multi-platform password manager
    # https://1password.com/
    home.packages = with pkgs; [ _1password-gui ];

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      perSystem.nur.repos.rycee.firefox-addons.onepassword-password-manager
    ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultPasswordManager [
        "Super&Alt, PERIOD, exec, uwsm app -- ${getExe pkgs._1password-gui}"
      ];
      windowrule = [
        "noscreenshare, class:1Password"
        "float, class:1Password, title:1Password"
        "size 650 620, class:1Password, title:1Password"
        "move 70% 10%, class:1Password, title:1Password"
        "opacity 1 0.5, class:1Password, title:1Password, floating:1"

        "center, class:1Password, title:(Lock Screen)"
        "size 600 450, class:1Password, title:(Lock Screen)"
      ];
      # titles: Lock Screen — 1Password ; All Items — 1Password ;
    };
    programs.niri.settings = {
      binds."Mod+Alt+Period" = mkIf cfg.setAsDefaultPasswordManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs._1password-gui}";
      };
      window-rules = [
        {
          matches = [ { app-id = "1Password"; } ];
          open-floating = true;
          default-window-height.fixed = 600;
          default-column-width.fixed = 450;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}

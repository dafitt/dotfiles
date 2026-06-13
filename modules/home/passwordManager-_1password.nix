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
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures 1Password password manager.
  #  <https://1password.com/>
  #'';

  options.dafitt.passwordManager-_1password = with types; {
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = {
    home.packages = with pkgs; [ _1password-gui ];

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      perSystem.nur.repos.rycee.firefox-addons.onepassword-password-manager
    ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultPasswordManager [
        {
          _args = [
            "SUPER + ALT + Period"
            (mkLuaInline ''hl.dsp.exec_cmd("uwsm app -- ${getExe pkgs._1password-gui}")'')
            { description = "Open 1Password"; }
          ];
        }
      ];
      window_rule = [
        {
          match.class = "1Password$";
          no_screen_share = true;
        }
        {
          match.class = "1Password$";
          match.title = "1Password$";
          float = true;
          size = "{650, 620}";
          move = ''{"(window_w*0.7)", "(window_h*0.1)"}'';
        }
        {
          match.class = "1Password$";
          match.title = "1Password$";
          match.float = true;
          opacity = "1 0.5";
        }
        {
          match.class = "1Password$";
          match.title = "^Lock Screen$";
          match.float = true;
          center = true;
          size = "{600, 450}";
        }
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

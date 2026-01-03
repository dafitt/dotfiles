{
  config,
  lib,
  pkgs,
  perSystem,
  ...
}:
with lib;
let
  cfg = config.dafitt.passwordManager-keepassxc;
in
{
  options.dafitt.passwordManager-keepassxc = with types; {
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = {
    programs.keepassxc = {
      enable = true;
    };

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      perSystem.nur.repos.rycee.firefox-addons.keepassxc-browser
    ];

    wayland.windowManager.hyprland.settings = {
      bind = optionals cfg.setAsDefaultPasswordManager [
        "Super&Alt, PERIOD, exec, uwsm app -- ${getExe pkgs.keepassxc}"
      ];
      windowrule = [
        "noscreenshare, class:keepassxc"
        "float, class:keepassxc, title:keepassxc"
      ];
    };
    programs.niri.settings = {
      binds."Mod+Alt+Period" = mkIf cfg.setAsDefaultPasswordManager {
        action.spawn-sh = "uwsm app -- ${getExe pkgs.keepassxc}";
      };
      window-rules = [
        {
          matches = [
            { app-id = "org\.keepassxc\.KeePassXC"; }
            { app-id = "org\.gnome\.World\.Secrets"; }
          ];
          open-floating = true;
          block-out-from = "screen-capture";
        }
      ];
    };
  };
}

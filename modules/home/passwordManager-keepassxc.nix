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
  #meta.doc = builtins.toFile "doc.md" "Installs and configures KeePassXC password manager.";

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

    programs.umbriel.settings = {
      keybinds."Mod+Alt+Period" = mkIf cfg.setAsDefaultPasswordManager {
        action = "spawn:${getExe pkgs.keepassxc}";
        repeat = false;
      };
      window_rule = [
        {
          match.app_id = "^org[.]keepassxc[.]KeePassXC$";
          default_floating = true;
        }
        {
          match.app_id = "^org[.]gnome[.]World[.]Secrets$";
          default_floating = true;
        }
      ];
    };
  };
}

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

    programs.umbriel.settings = {
      keybinds."Mod+Alt+Period" = mkIf cfg.setAsDefaultPasswordManager {
        action = "spawn:${getExe pkgs.bitwarden-desktop}";
        repeat = false;
      };
      window_rule = [
        {
          match.app_id = "^bitwarden$";
          default_floating = true;
        }
      ];
    };
  };
}

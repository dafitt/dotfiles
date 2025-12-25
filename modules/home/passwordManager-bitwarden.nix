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
      bind = mkIf cfg.setAsDefaultPasswordManager [
        "SUPER_ALT, PERIOD, exec, uwsm app -- ${pkgs.bitwarden-desktop}/bin/bitwarden"
      ];
      windowrule = [
        "noscreenshare, class:Bitwarden"
        "float, class:Bitwarden, title:Bitwarden"
      ];
    };
  };
}

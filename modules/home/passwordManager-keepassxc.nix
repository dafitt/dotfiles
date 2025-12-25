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
      bind = mkIf cfg.setAsDefaultPasswordManager [
        "SUPER_ALT, PERIOD, exec, uwsm app -- ${getExe pkgs.keepassxc}"
      ];
      windowrule = [
        "noscreenshare, class:keepassxc"
        "float, class:keepassxc, title:keepassxc"
      ];
    };
  };
}

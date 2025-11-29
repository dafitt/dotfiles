{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.keepassxc;
in
{
  options.dafitt.keepassxc = with types; {
    enable = mkEnableOption "KeePassXC";
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = mkIf cfg.enable {
    programs.keepassxc = {
      enable = true;
    };

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      pkgs.nur.repos.rycee.firefox-addons.keepassxc-browser
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

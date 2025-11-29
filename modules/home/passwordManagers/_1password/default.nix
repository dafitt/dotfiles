{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt._1password;
in
{
  options.dafitt._1password = with types; {
    enable = mkEnableOption "1Password";
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = mkIf cfg.enable {
    # Multi-platform password manager
    # https://1password.com/
    home.packages = with pkgs; [ _1password-gui ];

    programs.firefox.profiles.${config.home.username}.extensions.packages = [
      pkgs.nur.repos.rycee.firefox-addons.onepassword-password-manager
    ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultPasswordManager [
        "SUPER_ALT, PERIOD, exec, uwsm app -- ${pkgs._1password-gui}/bin/1password"
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
  };
}

{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManager._1password;
  passwordManagerCfg = config.dafitt.passwordManager;

  isDefault = passwordManagerCfg.default == "_1password";
in
{
  options.dafitt.passwordManager._1password = with types; {
    enable = mkBoolOpt isDefault "Whether to enable _1password.";
  };

  config = mkIf cfg.enable {
    # Multi-platform password manager
    # https://1password.com/
    home.packages = with pkgs; [ _1password-gui ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, PERIOD, exec, ${pkgs._1password-gui}/bin/1password" ];
      windowrulev2 = [
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

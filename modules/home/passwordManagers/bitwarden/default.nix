{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManagers.bitwarden;
in
{
  options.dafitt.passwordManagers.bitwarden = with types; {
    enable = mkEnableOption "password manager 'bitwarden'";

    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ bitwarden-desktop ];

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, PERIOD, exec, uwsm app -- ${pkgs.bitwarden-desktop}/bin/bitwarden" ];
      windowrule = [
        "float, class:Bitwarden, title:Bitwarden"
      ];
    };
  };
}

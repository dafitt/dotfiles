{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.passwordManager.bitwarden;
in
{
  options.dafitt.environment.passwordManager.bitwarden = with types; {
    enable = mkBoolOpt
      (config.dafitt.environment.enable &&
        config.dafitt.environment.passwordManager.default == "bitwarden") "Enable bitwarden.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ bitwarden-desktop ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, PERIOD, exec, ${pkgs.bitwarden-desktop}/bin/bitwarden" ];
      windowrulev2 = [ ];
    };
  };
}

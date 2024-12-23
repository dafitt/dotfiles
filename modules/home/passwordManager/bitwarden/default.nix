{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManager.bitwarden;
  passwordManagerCfg = config.dafitt.passwordManager;

  isDefault = passwordManagerCfg.default == "bitwarden";
in
{
  options.dafitt.passwordManager.bitwarden = with types; {
    enable = mkBoolOpt isDefault "Whether to enable bitwarden.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ bitwarden-desktop ];

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, PERIOD, exec, ${pkgs.bitwarden-desktop}/bin/bitwarden" ];
      windowrulev2 = [
        "float, class:Bitwarden, title:Bitwarden"
      ];
    };
  };
}

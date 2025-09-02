{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bitwarden;
in
{
  options.dafitt.bitwarden = with types; {
    enable = mkEnableOption "Bitwarden";
    setAsDefaultPasswordManager = mkEnableOption "making it the default password manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ bitwarden-desktop ];

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

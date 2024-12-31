{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.launchers;
in
{
  options.dafitt.launchers = with types;{
    default = mkOption {
      type = nullOr (enum [
        "fuzzel"
        "rofi"
      ]);
      default = null;
      description = "Which application launcher will be used primarily.";
    };
  };

  config.dafitt.launchers = {
    fuzzel = mkIf (cfg.default == "fuzzel") {
      enable = true;
      configureKeybindings = true;
    };
    rofi = mkIf (cfg.default == "rofi") {
      enable = true;
      configureKeybindings = true;
    };
  };
}
